//
//  UIStackView+.swift
//  DesignKit-iOS
//
//  Created by Kwanghyun.won on 2019/11/27.
//  Copyright © 2019 Vingle. All rights reserved.
//

import UIKit

// MARK: - Layout

public extension UIStackView {
    @discardableResult
    func withMargins(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }

    @discardableResult
    func padLeft(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }

    @discardableResult
    func padTop(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }

    @discardableResult
    func padBottom(_ bottom: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }

    @discardableResult
    func padRight(_ right: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }
}

// MARK: - Builder

public extension UIStackView {
    func distribution(justify: UIStackView.Distribution) -> UIStackView {
        distribution = justify
        return self
    }
}

public extension UIStackView {
    @discardableResult
    func addDebug() -> UIStackView {
        let subview = UIView(frame: bounds)
        let randomColor = UIColor.random
        subview.backgroundColor = randomColor.withAlphaComponent(0.3)
        subview.setBorder(width: 1, color: randomColor)
        subview.setCorner(3)
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subview, at: 0)
        return self
    }
}

// MARK: - utility

public extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })

        // Remove the views from self
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
