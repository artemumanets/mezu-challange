//
//  FLResponseFindByUserName.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLResponseFindByUserName: ResponseProtocol {

    let user: FLUser
}

struct FLUser: ResponseProtocol {

    let nsid: String
    let username: FLUserName
}

struct FLUserName: ResponseProtocol {

    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "_content"
    }
}
