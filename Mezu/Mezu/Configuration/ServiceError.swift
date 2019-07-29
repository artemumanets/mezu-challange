//
//  ServiceError.swift
//  Mezu
//
//  Created by Artem Umanets on 23/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

enum ServiceError<E: ResponseProtocol>: Error {
    case invalidAPIUrl
    case unexpectedAPIResponse
    case httpError(Int)
    case error(Error)
    case apiError(E)
}

extension ServiceError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidAPIUrl: return "Error.APIInvalidURL".localized
        case .unexpectedAPIResponse: return "Error.APIGeneric".localized
        case .httpError(let statusCode): return "Error.APIHTTPStatusCode".localized + " \(statusCode)"
        case .error(let error): return error.localizedDescription
        case .apiError(_): return "Error.APIGeneric".localized
        }
    }
}

extension ServiceError {

    func message<E: ResponseProtocol>(withFilter filterCallback: (E) -> String?) -> String? {

        var errorMessage: String? = nil
        switch self {
        case .apiError(let error):
            if let error = error as? E {
                errorMessage = filterCallback(error)
            }
        default: break
        }

        return errorMessage
    }
}
