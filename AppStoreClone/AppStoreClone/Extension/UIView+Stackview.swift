//
//  UIView+Stackview.swift
//  DesignKit-iOS
//
//  Created by ios_dev on 2019/11/27.
//  Copyright © 2019 Vingle. All rights reserved.
//

import UIKit

public extension UIView {
    fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical,
                            alignment: UIStackView.Alignment = .fill,
                            spacing: CGFloat = 0,
                            distribution: UIStackView.Distribution = .fill,
                            views: [UIView]) -> UIStackView
    {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        addSubview(stackView)
        stackView.pinInSuperview()
        return stackView
    }

    @discardableResult
    func VStackView(alignment: UIStackView.Alignment = .fill,
                    spacing: CGFloat = 0,
                    _ view: UIView) -> UIStackView
    {
        return _stack(.vertical, alignment: alignment, spacing: spacing, distribution: .fill, views: [view])
    }

    @discardableResult
    func VStackView(alignment: UIStackView.Alignment = .fill,
                    spacing: CGFloat = 0,
                    @StackBuilder _ views: () -> [UIView]) -> UIStackView
    {
        return _stack(.vertical, alignment: alignment, spacing: spacing, distribution: .fill, views: views())
    }

    @discardableResult
    func HStackView(alignment: UIStackView.Alignment = .fill,
                    spacing: CGFloat = 0,
                    _ view: UIView) -> UIStackView
    {
        return _stack(.horizontal, alignment: alignment, spacing: spacing, distribution: .fill, views: [view])
    }

    @discardableResult
    func HStackView(alignment: UIStackView.Alignment = .fill,
                    spacing: CGFloat = 0,
                    @StackBuilder _ views: () -> [UIView]) -> UIStackView
    {
        return _stack(.horizontal, alignment: alignment, spacing: spacing, distribution: .fill, views: views())
    }

    @discardableResult
    func withSize<T: UIView>(_ size: CGSize) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        // swiftlint:disable:next force_cast
        return self as! T
    }

    @discardableResult
    func withSize<T: UIView>(_ allSide: CGFloat) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        let size: CGSize = .init(width: allSide, height: allSide)
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        // swiftlint:disable:next force_cast
        return self as! T
    }

    @discardableResult
    func withHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }

    @discardableResult
    func withWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }

    @discardableResult
    func withBorder<T: UIView>(width: CGFloat, color: UIColor) -> T {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self as! T // swiftlint:disable:this force_cast
    }
}

public extension CGSize {
    static func allSide(_ value: CGFloat) -> CGSize {
        return .init(width: value, height: value)
    }
}

public extension UIEdgeInsets {
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    static func allSides(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: side, bottom: side, right: side)
    }

    static func allSides(horizontal: CGFloat, vertical: CGFloat) -> UIEdgeInsets {
        return .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

class VerticalStackView: UIStackView {
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)

        arrangedSubviews.forEach { addArrangedSubview($0) }

        self.spacing = spacing
        self.axis = .vertical
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
