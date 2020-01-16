//
//  UIView+.swift
//  Example
//
//  Created by kwanghyun.won on 2019/11/06.
//  Copyright © 2019 vingle. All rights reserved.
//

import UIKit

public typealias Spacer = UIView

public enum anchorAxis: Int {
    case x
    case y
    case xy
}

public extension UIView {
    // MARK: - Frame
    var left: CGFloat {
        get { return frame.minX }
        set { frame.origin.x = newValue }
    }
    var right: CGFloat {
        get { return frame.maxX }
        set { frame.origin.x = newValue - width }
    }
    var top: CGFloat {
        get { return frame.minY }
        set { frame.origin.y = newValue }
    }
    var bottom: CGFloat {
        get { return frame.maxY }
        set { frame.origin.y = newValue - height }
    }
    var width: CGFloat {
        get { return frame.width }
        set { frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return frame.height }
        set { frame.size.height = newValue }
    }

    private var contentWidth: CGFloat {
        return (self as? UIScrollView)?.contentSize.width ?? bounds.width
    }

    // MARK: - AutoLayout
    struct AnchoredConstraints {
        public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
    }

    func fitIntoSuperview(
        usingConstraints: Bool = false,
        usingLeadingTrailing: Bool = true,
        margins: UIEdgeInsets = .zero,
        autoWidth: Bool = false,
        autoHeight: Bool = false
    ) {
        guard let superview = superview else {
            return
        }
        if usingConstraints {
            translatesAutoresizingMaskIntoConstraints = false
            if usingLeadingTrailing {
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margins.left).isActive = true
            } else {
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: margins.left).isActive = true
            }
            if autoWidth {
                if usingLeadingTrailing {
                    trailingAnchor.constraint(
                        equalTo: superview.trailingAnchor,
                        constant: -margins.right
                    ).isActive = true
                } else {
                    rightAnchor.constraint(
                        equalTo: superview.rightAnchor,
                        constant: -margins.right
                    ).isActive = true
                }
            } else {
                widthAnchor.constraint(
                    equalTo: superview.widthAnchor,
                    constant: -(margins.left + margins.right)
                ).isActive = true
            }
            topAnchor.constraint(equalTo: superview.topAnchor, constant: margins.top).isActive = true
            if autoHeight {
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -margins.bottom).isActive = true
            } else {
                heightAnchor.constraint(
                    equalTo: superview.heightAnchor,
                    constant: -(margins.top + margins.bottom)
                ).isActive = true
            }
        } else {
            translatesAutoresizingMaskIntoConstraints = true
            frame = superview.bounds.inset(by: margins)
            autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }

    func fitIntoSuperview() {
        fitIntoSuperview(
            usingConstraints: false,
            usingLeadingTrailing: true,
            margins: .zero,
            autoWidth: false,
            autoHeight: false
        )
    }

    func pinInSuperview() {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func centerInSuperview(axis: anchorAxis = .xy) {
        guard let superview = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        
        switch axis {
        case .x:
            centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        case .y:
            centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        case .xy:
            centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
    }

    func insect(by insect: UIEdgeInsets) {
        guard let superview = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insect.left).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insect.right).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor, constant: insect.top).isActive = true
        if insect.bottom != 0 {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insect.bottom).isActive = true
        }
    }

    func anchorSuperview(top: CGFloat? = nil, leading: CGFloat? = nil,
                bottom: CGFloat? = nil, trailing: CGFloat? = nil) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                                    constant: -bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        }
    }

    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                 leading: NSLayoutXAxisAnchor? = nil,
                 bottom: NSLayoutYAxisAnchor? = nil,
                 trailing: NSLayoutXAxisAnchor? = nil,
                 padding: UIEdgeInsets = .zero,
                 size: CGSize = .zero) -> AnchoredConstraints {

        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else {
            return AnchoredConstraints(top: nil, leading: nil, bottom: nil,
                                       trailing: nil, width: nil, height: nil)
        }

        var anchoredConstraints = AnchoredConstraints()

        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        } else {
            anchoredConstraints.top = topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top)
        }

        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        } else {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: superview.leadingAnchor,
                                                                   constant: padding.left)
        }

        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        } else {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                                                 constant: -padding.bottom)
        }

        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        } else {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor,
                                                                     constant: -padding.right)
        }

        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }

        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }

        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing,
         anchoredConstraints.width,
         anchoredConstraints.height].compactMap { $0 }.forEach { $0?.isActive = true }

        return anchoredConstraints
    }

    func pinInSize(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func pinInSize(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func pinInSize(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: height).isActive = true
    }

}

// MARK: - layer
public extension UIView {

    func roundCorner(_ radius: CGFloat = 8, isBorderShow: Bool = true) {
        layer.cornerRadius = radius
        clipsToBounds = true
        if isBorderShow {
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 0.5
        }
    }

    func layer(withRoundedCorners corners: UIRectCorner, radius: CGFloat) -> CALayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: bounds,
                                  byRoundingCorners: corners,
                                  cornerRadii: CGSize(width: radius, height: radius)).cgPath
        return layer
    }

    @discardableResult
    func setCorner(_ radius: CGFloat) -> UIView {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }

    @discardableResult
    func setShadow(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float) -> UIView {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        return self
    }

    @discardableResult
    func setBorder(width: CGFloat) -> UIView {
        layer.borderWidth = width
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    func setBorder(_ color: UIColor) -> UIView {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    func setBorder(width: CGFloat, color: UIColor) -> UIView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
}

// MARK: - Builder
public extension UIView {
    convenience init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }

    @discardableResult
    func debug() -> UIView {
        let randomColor = UIColor.random
        backgroundColor = randomColor.withAlphaComponent(0.3)
        setBorder(width: 1, color: randomColor)
        setCorner(3)
        return self
    }
}
