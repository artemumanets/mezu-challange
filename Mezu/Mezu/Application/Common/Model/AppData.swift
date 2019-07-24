//
//  AppData.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

class AppData {

    static let shared = AppData()

    var user: User!
    
    private init() {}
}
