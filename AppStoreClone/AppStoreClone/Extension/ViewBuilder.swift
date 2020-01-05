//
//  ViewBuilder.swift
//  DesignKit-iOS
//
//  Created by kwanghyun.won on 2019/11/27.
//  Copyright © 2019 Vingle. All rights reserved.
//

import UIKit

@_functionBuilder
public struct StackBuilder {
    public static func buildBlock(_ segments: UIView...) -> [UIView] {
        var views: [UIView] = []
        segments.forEach {
            views.append($0)
        }

        return views
    }
}
