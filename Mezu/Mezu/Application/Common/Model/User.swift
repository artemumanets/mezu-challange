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

    init(response: FLResponseFindByUserName) {
        self.nsid = response.user.nsid
    }
}
