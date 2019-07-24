//
//  ServiceError.swift
//  Mezu
//
//  Created by Artem Umanets on 23/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case invalidAPIUrl
    case unexpectedAPIResponse
    case httpError(Int)
}

extension ServiceError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .invalidAPIUrl: return "Error.APIInvalidURL".localized
        case .unexpectedAPIResponse: return "Error.APIGeneric".localized
        case .httpError(let statusCode): return "Error.APIHTTPStatusCode".localized + " \(statusCode)"
        }
    }
}
