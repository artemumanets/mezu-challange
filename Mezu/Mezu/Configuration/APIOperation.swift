//
//  APIOperation.swift
//  Mezu
//
//  Created by Artem Umanets on 03/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

enum APIOperation {

    case findByUserName([String: Any])

    var url: String {
        var operationUrl = "\(Configuration.Flickr.baseUrl)/"
        operationUrl += "?method=\(self.action.name)"
        operationUrl += "&api_key=\(Configuration.Flickr.apiKey)"
        operationUrl += "&nojsoncallback=1"
        operationUrl += "&format=\(Configuration.Flickr.responseFormat)"

        switch self {
        case .findByUserName(let args):
            operationUrl += "&\(args.queryString)"
        }

        return operationUrl
    }

    var method: RequestMethod {
        return self.action.method
    }

    private var action: APIAction {
        switch self {
        case .findByUserName(_): return APIAction(method: .get, name: "flickr.people.findByUsername")
        }
    }
}

private struct APIAction {

    let method: RequestMethod
    let name: String
}
