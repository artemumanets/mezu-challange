//
//  LoaderView.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class LoaderView: UIView {

    init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isUserInteractionEnabled = false
        indicator.color = R.Color.accent
        indicator.startAnimating()
        addSubview(indicator)

        let views = ["self" : self, "indicator" : indicator]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[indicator]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[indicator]|", options: [], metrics: nil, views: views)
        addConstraints(constraints)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
