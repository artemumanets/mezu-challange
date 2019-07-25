//
//  FetcherProtocol.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

typealias CallbackOnSuccess<T> = (T) -> ()
typealias CallbackOnError = (Error) -> ()
typealias CallbackFinally = () -> ()
typealias CallbackOnImageDidLoad = (UIImage) -> ()

protocol FetcherProtocol {

    func fetch<T: ResponseProtocol>(request: RequestProtocol,
                                    onSuccess: @escaping CallbackOnSuccess<T>,
                                    onError: @escaping CallbackOnError,
                                    onFinally: CallbackFinally?)

    @discardableResult
    func fetchImageFrom(url: URL, onDidLoad: @escaping CallbackOnImageDidLoad) -> URLSessionDataTask?
}

extension FetcherProtocol {

    func fetch<T: ResponseProtocol>(request: RequestProtocol,
                                    onSuccess: @escaping CallbackOnSuccess<T>,
                                    onError: @escaping CallbackOnError) {
        
        fetch(request: request, onSuccess: onSuccess, onError: onError, onFinally: nil)
    }
}
