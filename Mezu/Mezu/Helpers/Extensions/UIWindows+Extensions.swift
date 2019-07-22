//
//  UIWindows+Extensions.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

public extension UIWindow {

    var visibleViewController: UIViewController {

        return UIWindow.getVisibleViewController(from: self.rootViewController!)
    }

    private class func getVisibleViewController(from vc: UIViewController) -> UIViewController {

        if let visibleViewController = (vc as? UINavigationController)?.visibleViewController { return UIWindow.getVisibleViewController(from: visibleViewController) }
        else if let visibleViewController = (vc as? UITabBarController)?.selectedViewController { return UIWindow.getVisibleViewController(from: visibleViewController) }
        else {
            if let presentedViewController = vc.presentedViewController { return UIWindow.getVisibleViewController(from: presentedViewController)
            } else { return vc }
        }
    }
}
