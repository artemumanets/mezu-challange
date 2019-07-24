//
//  UITextField+Extensions.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func set(placeholder: String?, placeholderColor: UIColor? = nil, textColor: UIColor? = nil, borderColor: UIColor? = nil) {

        if let textColor = textColor {
            self.textColor = textColor
        }
        if let placeholder = placeholder {
            var attributes = [NSAttributedString.Key: Any]()
            if let placeholderColor = placeholderColor {
                attributes[NSAttributedString.Key.foregroundColor] = placeholderColor
            }
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }

        if let borderColor = borderColor {
            self.layer.cornerRadius = 8.0
            self.layer.masksToBounds = true
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1.0
        }
    }
}
