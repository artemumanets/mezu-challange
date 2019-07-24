//
//  FLRequestFindByUserName.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLRequestFindByUserName: RequestProtocol {

    var operation: APIOperation { return .findByUserName(args) }

    private let args: [String: Any]

    init(username: String) {
        args = [Argument.username: username]
    }
}

private enum Argument {

    static let username = "username"
}
