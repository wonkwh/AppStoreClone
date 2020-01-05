//
//  UIViewController+.swift
//  DesignKit-iOS
//
//  Created by kwanghyun.won on 2019/11/26.
//  Copyright © 2019 Vingle. All rights reserved.
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
