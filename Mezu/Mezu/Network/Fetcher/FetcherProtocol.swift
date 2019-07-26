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
typealias CallbackOnError<E: ResponseProtocol> = (ServiceError<E>) -> ()
typealias CallbackFinally = () -> ()
typealias CallbackOnImageDidLoad = (UIImage) -> ()

protocol FetcherProtocol {

    func fetch<T: ResponseProtocol, E: ResponseProtocol>(request: RequestProtocol,
                                    onSuccess: @escaping CallbackOnSuccess<T>,
                                    onError: @escaping CallbackOnError<E>,
                                    onFinally: CallbackFinally?)

    @discardableResult
    func fetchImageFrom(url: URL, onDidLoad: @escaping CallbackOnImageDidLoad) -> URLSessionDataTask?
}

extension FetcherProtocol {

    func fetch<T: ResponseProtocol, E: ResponseProtocol>(request: RequestProtocol,
                                    onSuccess: @escaping CallbackOnSuccess<T>,
                                    onError: @escaping CallbackOnError<E>) {
        
        fetch(request: request, onSuccess: onSuccess, onError: onError, onFinally: nil)
    }
}
