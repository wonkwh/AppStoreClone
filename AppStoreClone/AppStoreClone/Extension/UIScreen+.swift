//
//  UIScreen+.swift
//  Example
//
//  Created by ios_dev on 2019/11/06.
//  Copyright © 2019 vingle. All rights reserved.
//

import UIKit

public extension UIScreen {
    class var width: CGFloat {
        return UIScreen.main.bounds.width
    }

    class var height: CGFloat {
        return UIScreen.main.bounds.height
    }

    var devicePixel: CGFloat { return 1 / scale }

    class var isPortrait: Bool {
        return UIScreen.main.bounds.height > UIScreen.main.bounds.width
    }

    class var isLandscape: Bool { return !isPortrait }

    ///   For example:
    ///  calculated = 52.666666666666671
    ///      actual = 52.666667938232422
    func roundToDevicePixels(_ value: CGFloat) -> CGFloat {
        return ceil(ceil(value * scale) / scale * 1_000) / 1_000
    }

    func roundDownToDevicePixels(_ value: CGFloat) -> CGFloat {
        return floor(value * scale) / scale
    }

    func middleOrigin(_ containerSizeValue: CGFloat, containedSizeValue: CGFloat) -> CGFloat {
        return roundDownToDevicePixels((containerSizeValue - containedSizeValue) / 2.0)
    }
}
