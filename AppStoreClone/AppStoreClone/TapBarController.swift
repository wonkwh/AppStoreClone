//
//  TapBarController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/03.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class TapbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let todayVC = UIViewController()
        todayVC.view.backgroundColor = .systemBackground
        let todayController = UINavigationController(rootViewController: todayVC)
        todayVC.navigationItem.title = "TODAY"
        todayController.tabBarItem.title = "TODAY"
        todayController.navigationBar.prefersLargeTitles = true
        todayController.tabBarItem.image = #imageLiteral(resourceName: "today_icon")

        let redVc = UIViewController()
        redVc.view.backgroundColor = .systemBackground
        let redController = UINavigationController(rootViewController: redVc)
        redVc.navigationItem.title = "APPS"
        redController.tabBarItem.title = "APPS"
        redController.navigationBar.prefersLargeTitles = true
        redController.tabBarItem.image = #imageLiteral(resourceName: "apps")

        let blueVc = UIViewController()
        blueVc.view.backgroundColor = .systemBackground
        let blueController = UINavigationController(rootViewController: blueVc)
        blueVc.navigationItem.title = "SEARCH"
        blueController.tabBarItem.title = "SEARCH"
        blueController.navigationBar.prefersLargeTitles = true
        blueController.tabBarItem.image = #imageLiteral(resourceName: "search")

        viewControllers = [
            todayController,
            redController,
            blueController
        ]
    }
}

