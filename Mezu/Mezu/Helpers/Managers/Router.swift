//
//  Router.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Be Pure Inside. All rights reserved.
//

import Foundation
import UIKit

typealias NavigationCallback = () -> ()

protocol Navigator {
    associatedtype Destination

    static func navigate(from vc: UIViewController, to destination: Destination, completion: NavigationCallback?)
}

class Router {

    private init() {}

    enum Destination {
        case list
        case details(Photo)
        case info
    }

    private static func getController(for destination: Router.Destination) -> UIViewController {

        switch destination {
        case .details(let photo): return DetailsViewController(photo: photo)
        case .list: return NavigationController(rootViewController: ListViewController())
        case .info: return NavigationController(rootViewController: InfoViewController())
        }
    }
}

extension Router {

    static func push(from vc: UIViewController, to destination: Router.Destination, completion: NavigationCallback? = nil) {
        vc.navigationController?.pushViewController(getController(for: destination), animated: true)
    }
    static func modal(from vc: UIViewController, to destination: Router.Destination, completion: NavigationCallback? = nil) {

        vc.present(getController(for: destination), animated: true, completion: completion)
    }
}
