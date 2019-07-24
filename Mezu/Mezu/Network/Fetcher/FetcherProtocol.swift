//
//  FetcherProtocol.swift
//  Mezu
//
//  Created by Artem Umanets on 05/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

typealias CallbackOnSuccess<T> = (T) -> ()
typealias CallbackOnError = (Error) -> ()
typealias CallbackFinally = () -> ()

protocol FetcherProtocol {

    func fetch<T: ResponseProtocol>(request: RequestProtocol,
                                    onSuccess: @escaping CallbackOnSuccess<T>,
                                    onError: @escaping CallbackOnError,
                                    onFinally: CallbackFinally?)
}

extension FetcherProtocol {

    func fetch<T: ResponseProtocol>(request: RequestProtocol,
                                    onSuccess: @escaping CallbackOnSuccess<T>,
                                    onError: @escaping CallbackOnError) {
        
        fetch(request: request, onSuccess: onSuccess, onError: onError, onFinally: nil)
    }
}
