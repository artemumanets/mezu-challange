//
//  Configuration.swift
//  Mezu
//
//  Created by Artem Umanets on 23/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

enum Configuration {

    enum Flickr {
        
        static var baseUrl: String { return "https://www.flickr.com/services/rest" }
        static var apiKey: String { return "f9cc014fa76b098f9e82f1c288379ea1" }
        static var responseFormat: String { return "json" }

        static var listPageSize: Int = 50
        static var listFirstPage: Int = 1
    }
}

enum Animation {

    static let fast = 0.15
    static let normal = 0.3
}
