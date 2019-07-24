//
//  ThemeManager.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

enum R {

    enum Color {

        static let background = UIColor(hex: 0x2f2f2f)
        static let content = UIColor(hex: 0xf3f3f3)
        static let placeholder = Color.content.withAlphaComponent(0.5)
        static let noImage = UIColor(hex: 0xf3f3f3).withAlphaComponent(0.1)
        static let accent = UIColor(hex: 0xff017e)

        enum Navigation {
            
            static let background = UIColor(hex: 0x0f5fda)
            static let content = UIColor(hex: 0xffffff)
            static let separator = UIColor(hex: 0x07419a)
        }
    }

    enum Font {

        static let heading = UIFont(name: "Avenir-Black", size: 22.0)!
        static let title = UIFont(name: "Futura-Medium", size: 18.0)!
        static let content = UIFont(name: "Avenir-Medium", size: 16.0)!
        static let subcontent = UIFont(name: "Avenir-Light", size: 12.0)!
    }

    enum Layout {

        enum List {

            static let space: CGFloat = 20.0
            static let cornerRadius: CGFloat = 16.0
        }
    }
}