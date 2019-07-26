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
        static let accent = UIColor(hex: 0xff017e)

        static let subcontent = UIColor(hex: 0xdfdfdf)
        static let placeholder = Color.content.withAlphaComponent(0.8)
        static let noImage = UIColor(hex: 0xf3f3f3).withAlphaComponent(0.1)

        enum Navigation {
            
            static let background = UIColor(hex: 0x0f5fda)
            static let content = UIColor(hex: 0xffffff)
            static let separator = UIColor(hex: 0x07419a)
        }
    }

    enum Font {

        static let heading = UIFont(name: "Avenir-Black", size: 20.0)!
        static let content = UIFont(name: "Avenir-Medium", size: 16.0)!
        static let subheading = UIFont(name: "Avenir-Black", size: 13.0)!
        static let subcontent = UIFont(name: "Avenir-Light", size: 12.0)!
        static let smallcontent = UIFont(name: "Avenir-Medium", size: 10.0)!
    }

    enum Image {

        static let buttonClose = UIImage(named: "ButtonClose")!
        static let mezuLogo = UIImage(named: "MezuLogo")!
        static let myPhoto = UIImage(named: "MyPhoto")!
        static let iconSearch = UIImage(named: "IconSearch")!
    }

    enum Layout {

        static let margin: CGFloat = 20.0
        static let cornerRadius: CGFloat = 16.0

        enum Photo {

            static func newSize(for photoSize: CGSize?) -> CGSize {

                let expectedWidth = UIScreen.main.bounds.width - Layout.margin * 2.0
                guard let size = photoSize else {
                    return CGSize(width: expectedWidth, height: UIScreen.main.bounds.width * 0.65)
                }

                let expectedHeight = expectedWidth * size.height / size.width
                return CGSize(width: expectedWidth, height: expectedHeight)
            }
        }

        enum Details {
            static let tagSpace: CGFloat = 4.0
        }

        enum Formatting {

            static let emptyString: String = "Global.NotAvailable".localized
            static let emptyDate: String = "Global.NotAvailable".localized
        }
    }
}
