//
//  AppDelegate.swift
//  AppStoreClone
//
//  Created by ios_dev on 2020/01/03.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TapbarController()
        window?.makeKeyAndVisible()

        return true
    }
}
