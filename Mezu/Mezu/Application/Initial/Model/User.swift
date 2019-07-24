//
//  User.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct User {

    let nsid: String
    let name: String

    init(response: FLResponseFindByUserName) {
        self.nsid = response.user.nsid
        self.name = response.user.username.name
    }
}
