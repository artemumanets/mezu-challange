//
//  String+Extensions.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var capitalizedFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }
}
