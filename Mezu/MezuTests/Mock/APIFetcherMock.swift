//
//  MockAPIFetcher.swift
//  Mezu Tests
//
//  Created by Artem Umanets on 29/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit
@testable import Mezu

// This fetcher uses data preloaded json response files instead of web api
class APIFetcherMock: FetcherProtocol {

    private let parser: ParserProtocol

    static var `default`: APIFetcherMock { return APIFetcherMock(parser: JSONDataParser()) }

    init(parser: ParserProtocol) {
        self.parser = parser
    }

    func fetch<T, E>(request: RequestProtocol, onSuccess: @escaping (T) -> (), onError: @escaping (ServiceError<E>) -> (), onFinally: CallbackFinally?) where T : ResponseProtocol, E : ResponseProtocol {

        let wrappedError: CallbackOnError = { (error: ServiceError<E>) in
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
                let object: T = try self.parser.parse(data: data)
                wrappedSuccess(object)
            } catch _ {
                wrappedError(.unexpectedAPIResponse)
            }
        }

        make(request: request, onSuccess: { data in
            parseData(data)
        }) { (error: ServiceError<E>) in
            wrappedError(.error(error))
        }
    }

    func fetch<T, E>(request: RequestProtocol, onSuccess: @escaping (T) -> (), onError: @escaping (ServiceError<E>) -> ()) where T : ResponseProtocol, E : ResponseProtocol {
        fetch(request: request, onSuccess: onSuccess, onError: onError, onFinally: nil)
    }

    func fetchImageFrom(url: URL, onDidLoad: @escaping CallbackOnImageDidLoad) {

    }

    private func make<E: ResponseProtocol>(request: RequestProtocol,
                                           onSuccess: @escaping CallbackOnSuccess<Data>,
                                           onError: @escaping (ServiceError<E>) -> ()) {
        var url = request.operation.url
        if url.last == "/" { url = String(url.dropLast()) }
        let fileName = url.replacingOccurrences(of: "http://", with: "")
            .replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "?", with: "_")
            .replacingOccurrences(of: "/", with: "_")

        let bundle = Bundle(for: type(of: self))
        if let filePath = bundle.path(forResource: fileName, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filePath)
                onSuccess(contents.data(using: .utf8) ?? Data())
            } catch let error {
                onError(.error(error))
            }
        } else {
            onError(.invalidAPIUrl)
        }
    }
}
