//
//  FLResponseError.swift
//  Mezu
//
//  Created by Artem Umanets on 26/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLResponseError: ResponseProtocol {

    let stat: String
    let code: Int
    let message: String
}
