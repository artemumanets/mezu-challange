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
        
        var output: String = ""
        for (key,value) in self {
            if let v = value as? String, v == "" { continue }
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        output = output.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return output
    }
}
