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
        static var apiKey: String { return "0e1ff6dbe99242bfdf44c80206eaa428" }
        static var responseFormat: String { return "json" }

        static var listPageSize: Int = 50
        static var listFirstPage: Int = 1
    }
}

enum Animation {

    static let fast = 0.15
    static let normal = 0.3
}
