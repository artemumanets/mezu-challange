//
//  RequestProtocol.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

enum RequestMethod: String {

    case get = "GET"
    case post = "POST"
}

protocol RequestProtocol {

    var operation: APIOperation { get }
    var body: Data? { get }

    var cacheResponse: Bool { get }
}

extension RequestProtocol {

    var body: Data? { return nil }
    var cacheResponse: Bool { return true }
}
