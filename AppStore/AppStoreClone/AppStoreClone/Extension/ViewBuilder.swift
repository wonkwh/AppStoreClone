//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

@resultBuilder
public enum StackBuilder {
    public static func buildBlock(_ segments: UIView...) -> [UIView] {
        var views: [UIView] = []
        segments.forEach {
            views.append($0)
        }

        return views
    }
}
