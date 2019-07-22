//
//  ErrorManager.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

class ErrorManager {

    private init() {}
    
    static func show(error: Error, retryCallback: AlertRetryCallback? = nil) {
        let alertController = AlertController(error: error, retryCallback: retryCallback)
        alertController.show()
    }

    static func show(description: String, retryCallback: AlertRetryCallback? = nil) {
        let alertController = AlertController(description: description, retryCallback: retryCallback)
        alertController.show()
    }
}
