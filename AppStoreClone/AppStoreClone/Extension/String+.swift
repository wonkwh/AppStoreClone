//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

public extension String {
    func attributedString(font: UIFont, color: UIColor? = nil, customLineHeight: CGFloat? = nil,
                          alignment: NSTextAlignment? = nil, kern: Double? = nil,
                          lineBreakMode: NSLineBreakMode? = nil, underlineStyle: NSUnderlineStyle? = nil,
                          strikeThroughStyle: NSUnderlineStyle? = nil) -> NSAttributedString
    {
        let finalKern: Double = kern ?? 0.0
        let finalLineHeight: CGFloat = customLineHeight ?? font.lineHeight
        let finalColor: UIColor = color ?? .black

        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineSpacing = finalLineHeight - font.lineHeight

        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }

        if let lineBreakMode = lineBreakMode {
            paragraphStyle.lineBreakMode = lineBreakMode
        }

        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: finalColor,
            .font: font,
            .kern: finalKern,
            .paragraphStyle: paragraphStyle
        ]

        if let underlineStyle = underlineStyle {
            attributes.updateValue(underlineStyle.rawValue, forKey: .underlineStyle)
        }

        if let strikeThroughStyle = strikeThroughStyle {
            attributes.updateValue(strikeThroughStyle.rawValue, forKey: .strikethroughStyle)
        }

        return NSAttributedString(string: self, attributes: attributes)
    }
}
