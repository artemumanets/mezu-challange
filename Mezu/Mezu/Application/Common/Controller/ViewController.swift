//
//  GenericViewController.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(type: UIViewController.Type?) {
        if let type = type {
            let classIdentifier = String(describing: type)
            super.init(nibName: classIdentifier, bundle: nil)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = R.Color.background
    }
}

extension ViewController {

    func assertViewModel(_ viewModel: Any?) {
        assert(viewModel != nil)
    }
}
