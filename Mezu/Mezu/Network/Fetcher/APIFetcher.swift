//
//  APIFetcher.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class APIFetcher: FetcherProtocol {

    static var `default`: APIFetcher { return APIFetcher(dataParser: JSONDataParser()) }

    private let dataParser: ParserProtocol

    init(dataParser: ParserProtocol) {
        self.dataParser = dataParser
    }

    func fetch<T: ResponseProtocol>(request: RequestProtocol,
                                    onSuccess: @escaping CallbackOnSuccess<T>,
                                    onError: @escaping CallbackOnError,
                                    onFinally: CallbackFinally?) {
        let wrappedError: CallbackOnError = { error in
            DispatchQueue.main.async {
                onError(error)
                onFinally?()
            }
        }

        let wrappedSuccess: CallbackOnSuccess<T> = { response in
            DispatchQueue.main.async {
                onSuccess(response)
                onFinally?()
            }
        }

        let parseData: (Data) -> Void = { (data: Data) in
            do {
                let object: T = try self.dataParser.parse(data: data)
                wrappedSuccess(object)
            } catch _ {
                wrappedError(ServiceError.unexpectedAPIResponse)
            }
        }

        make(request: request, onSuccess: { data in
            parseData(data)
        }) { error in
            wrappedError(error)
        }
    }

    private func make(request: RequestProtocol, onSuccess: @escaping CallbackOnSuccess<Data>, onError: @escaping CallbackOnError) {

        guard let url = URL(string: request.operation.url) else {
            onError(ServiceError.invalidAPIUrl)
            return
        }

        DispatchQueue.global(qos: .background).async {
            //            if request.cacheResponse, let cachedData = CacheManager.read(fromUrl: url) {
            //                onSuccess(cachedData)
            //            } else {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.operation.method.rawValue
            urlRequest.httpBody = request.body
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in

                if let error = error {
                    onError(error)
                }
                guard let data = data else {
                    onError(ServiceError.unexpectedAPIResponse)
                    return
                }
                if let httpStatusCode = (response as? HTTPURLResponse)?.statusCode, httpStatusCode != 200 {
                    onError(ServiceError.httpError(httpStatusCode))
                }
                //                    if !CacheManager.fileExists(atUrl: url) {
                //                        CacheManager.write(data: data, toUrl: url)
                //                    }
                onSuccess(data)
                                }
                task.resume()
//            }
        }
    }

    func fetchImageFrom(url: URL, onDidLoad: @escaping CallbackOnImageDidLoad) -> URLSessionDataTask? {
//        if CacheManager.fileExists(atUrl: url) {
//            DispatchQueue.global(qos: .background).async {
//                let data = CacheManager.read(fromUrl: url)
//                DispatchQueue.main.async {
//                    onDidLoad(Request.image(fromData: data, defaultImage: defaultImage))
//                }
//            }
//            return nil
//        }

        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
//                CacheManager.write(data: data, toUrl: url)
            }
            DispatchQueue.main.async {
                onDidLoad(APIFetcher.image(fromData: data))
            }
        }
        dataTask.resume()
        return dataTask
    }

    private static func image(fromData data: Data?) -> UIImage {
        var downloadedImage: UIImage = UIImage()
        if let data = data, let image = UIImage(data: data) {
            downloadedImage = image
        }
        return downloadedImage
    }
}
