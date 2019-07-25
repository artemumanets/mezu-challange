//
//  DateFormatter+Extensions.swift
//  Mezu
//
//  Created by Artem Umanets on 25/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

extension DateFormatter {

    convenience init(dateStyle: Style) {
        self.init()
        self.dateStyle = dateStyle
    }

    func formattedString(from date: Date?) -> String? {
        if let date = date {
            return self.string(from: date)
        }
        return nil
    }
}
