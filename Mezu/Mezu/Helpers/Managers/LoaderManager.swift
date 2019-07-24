//
//  LoaderManager.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class LoaderManager {

    static var shared = LoaderManager()

    private var loader = LoaderView()
    private var loaderCount = 0

    private init() {}

    func show() {
        if loader.superview == nil {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.addSubview(loader)
        }
        loaderCount += 1
    }

    func hide() {
        loaderCount -= 1
        if loaderCount == 0 {
            loader.removeFromSuperview()
        }
    }

    var isLoading: Bool {
        return loaderCount > 0
    }
}
