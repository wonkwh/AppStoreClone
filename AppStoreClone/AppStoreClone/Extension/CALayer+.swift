//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import QuartzCore

public extension CALayer {
    var isAnimating: Bool { return animationKeys()?.isEmpty == false }
}
