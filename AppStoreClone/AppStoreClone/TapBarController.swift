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

        viewControllers = [
            createTabNavController(title: "Today", vc: UIViewController(), tabImage: #imageLiteral(resourceName: "today_icon")),
            createTabNavController(title: "Apps", vc: UIViewController(), tabImage: #imageLiteral(resourceName: "apps")),
            createTabNavController(title: "Search", vc: AppSearchController(), tabImage: #imageLiteral(resourceName: "search"))
        ]
    }

    // TODO: - # createNavController and UIViewController extension for remove duplication
    private func createTabNavController(title: String, vc: UIViewController, tabImage: UIImage) -> UIViewController{
        vc.view.backgroundColor = .systemBackground
        let navController = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.image = tabImage

        return navController
    }
}

