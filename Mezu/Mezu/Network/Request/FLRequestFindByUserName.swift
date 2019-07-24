//
//  FLRequestFindByUserName.swift
//  Mezu
//
//  Created by Artem Umanets on 05/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLRequestFindByUserName: RequestProtocol {

    var operation: APIOperation { return .findByUserName(args) }

    private let args: [String: Any]

    init(username: String) {
        args = [Constant.argumentUsername: username]
    }
}

private enum Constant {

    static let argumentUsername = "username"
}
