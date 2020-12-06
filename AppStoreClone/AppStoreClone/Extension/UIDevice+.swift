//
//  UIDevice+.swift
//  DesignKit-iOS
//
//  Created by kwanghyun.won on 2019/11/26.
//  Copyright © 2019 Vingle. All rights reserved.
//

import UIKit

public extension UIDevice {
    class var isPad: Bool {
        return current.userInterfaceIdiom == .pad
    }

    class var isPhone: Bool {
        return current.userInterfaceIdiom == .phone
    }

    class var isPhone5or5s: Bool {
        return isPhone && (UIScreen.main.bounds.size.height == 568 || UIScreen.main.bounds.size.width == 568)
    }

    class var isPhone6orLarger: Bool {
        return isPhone && (UIScreen.main.bounds.size.height >= 667 || UIScreen.main.bounds.size.width >= 667)
    }

    class var isPhonePlus: Bool {
        return isPhone && (UIScreen.main.bounds.size.height == 736 || UIScreen.main.bounds.size.width == 736)
    }

    class var isPhoneX: Bool {
        return isPhone && (UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.width == 812)
    }

    class var isPadProLarge: Bool {
        return isPad && (UIScreen.main.bounds.size.height == 1_366 || UIScreen.main.bounds.size.width == 1_366)
    }
}
