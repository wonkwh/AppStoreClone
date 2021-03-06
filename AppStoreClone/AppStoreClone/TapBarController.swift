//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class TapbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createTabNavController(title: "Apps", vc: AppsController(), tabImage: #imageLiteral(resourceName: "apps")),
            createTabNavController(
                title: "Today",
                vc: TodayController(collectionViewLayout: UICollectionViewFlowLayout()),
                tabImage: #imageLiteral(resourceName: "today_icon")
            ),
            createTabNavController(
                title: "Search",
                vc: AppSearchController(collectionViewLayout: UICollectionViewFlowLayout()),
                tabImage: #imageLiteral(resourceName: "search")
            )
        ]
    }

    // TODO: - # createNavController and UIViewController extension for remove duplication
    private func createTabNavController(title: String, vc: UIViewController, tabImage: UIImage) -> UIViewController {
        vc.view.backgroundColor = .white
        let navController = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.image = tabImage

        return navController
    }
}
