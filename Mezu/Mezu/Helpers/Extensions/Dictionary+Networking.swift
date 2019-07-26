//
//  Dictionary+Networking.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

extension Dictionary {

    var queryString: String {

        var queryStringArgs = [String]()
        for (key,value) in self {
            if let v = value as? String, v == "" { continue }
            queryStringArgs.append("\(key)=\(value)")
        }
        queryStringArgs.sort()
        var output: String = ""
        queryStringArgs.forEach { output += "\($0)&" }

        output = String(output.dropLast())
        output = output.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return output
    }
}
