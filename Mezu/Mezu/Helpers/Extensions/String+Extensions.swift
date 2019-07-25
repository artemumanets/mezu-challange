//
//  String+Extensions.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var capitalizedFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }

    func size(withFont font: UIFont) -> CGSize {
        let attributes = [NSMutableAttributedString.Key.font: font]
        let attString = NSAttributedString(string: self, attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        let constrainedToSize = CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, constrainedToSize, nil)
    }
}
