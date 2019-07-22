//
//  ErrorAlertController.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

typealias AlertRetryCallback = () -> ()
class AlertController: UIAlertController {
    
    func show() {
        let viewController = (UIApplication.shared.delegate as? AppDelegate)?.window?.visibleViewController
        viewController?.present(self, animated: true, completion: nil)
    }
}

// MARK: Error Alert Controller
extension AlertController {

    convenience init(error: Error, retryCallback: AlertRetryCallback? = nil) {
        self.init(description: error.localizedDescription, retryCallback: retryCallback)
    }

    convenience init(description: String, retryCallback: AlertRetryCallback? = nil) {
        self.init(title: "Error.Title".localized, message: description, preferredStyle: .alert)
        addAction(UIAlertAction(title: "Global.Continue".localized, style: .default, handler: nil))
        if let retryCallback = retryCallback {
            addAction(UIAlertAction(title: "Global.Retry".localized, style: .default, handler: { _ in
                retryCallback()
            }))
        }
    }
}

// MARK: Informative Alert Controller
extension AlertController {

    convenience init(message: String) {
        self.init(title: "", message: message, preferredStyle: .alert)
        addAction(UIAlertAction(title: "Global.Ok".localized, style: .default, handler: nil))
    }
}
