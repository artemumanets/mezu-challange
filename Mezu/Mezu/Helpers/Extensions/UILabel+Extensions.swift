//
//  UILabel+Extensions.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func set(color: UIColor, font: UIFont? = nil, text: String? = nil) {
        self.textColor = color
        if let font = font { self.font = font }
        if let text = text { self.text = text }
    }
}
