//
//  APIOperation.swift
//  Mezu
//
//  Created by Artem Umanets on 23/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

enum APIOperation {

    case findByUserName([String: Any])
    case getPublicPhotos([String: Any])
    case getSizes([String: Any])

    var url: String {
        var operationUrl = "\(Configuration.Flickr.baseUrl)/"
        operationUrl += "?method=\(self.action.name)"
        operationUrl += "&api_key=\(Configuration.Flickr.apiKey)"
        operationUrl += "&nojsoncallback=1"
        operationUrl += "&format=\(Configuration.Flickr.responseFormat)"

        if action.queryString != "" {
            operationUrl += "&\(action.queryString)"
        }
        return operationUrl
    }

    var method: RequestMethod {
        return self.action.method
    }

    private var action: APIAction {
        switch self {
        case .findByUserName(let args): return APIAction(method: .get, name: "flickr.people.findByUsername", queryString: args.queryString)
        case .getPublicPhotos(let args): return APIAction(method: .get, name: "flickr.people.getPublicPhotos", queryString: args.queryString)
        case .getSizes(let args): return APIAction(method: .get, name: "flickr.photos.getSizes", queryString: args.queryString)
        }
    }
}

private struct APIAction {

    let method: RequestMethod
    let name: String
    let queryString: String
}
