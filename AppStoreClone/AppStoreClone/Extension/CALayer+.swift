//
//  CALayer+.swift
//  DesignKit-iOS
//
//  Created by kwanghyun.won on 2019/11/26.
//  Copyright © 2019 Vingle. All rights reserved.
//

import QuartzCore

public extension CALayer {
    var isAnimating: Bool { return animationKeys()?.isEmpty == false }
}
