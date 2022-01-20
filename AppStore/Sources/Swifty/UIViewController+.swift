//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

// MARK: - Add/Remove Child View Controller

public extension UIViewController {
    func addChildController(_ childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }

    func removeChildController(_ childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
}
