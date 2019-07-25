//
//  InitializationManager.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class InitializationManager {

    class func initialize(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {

        configureUI()
    }
    
    private static func configureUI() {
        UINavigationBar.appearance().barTintColor = R.Color.Navigation.background
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.font: R.Font.heading, .foregroundColor: R.Color.Navigation.content]
        UINavigationBar.appearance().shadowImage = R.Color.Navigation.separator.toImage(withSize: CGSize(width: 1.0, height: 1.0))
        UIBarButtonItem.appearance().tintColor = R.Color.Navigation.content
    }

    class func createAppWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = InitialViewController()
        window.backgroundColor = R.Color.background
        window.makeKeyAndVisible()
        return window
    }
}
