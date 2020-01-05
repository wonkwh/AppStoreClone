//
//  String+.swift
//  DesignKit-iOS
//
//  Created by kwanghyun.won on 2019/11/21.
//  Copyright © 2019 Vingle. All rights reserved.
//

import UIKit

public extension String {

    func attributedString(font: UIFont, color: UIColor? = nil, customLineHeight: CGFloat? = nil,
                          alignment: NSTextAlignment? = nil, kern: Double? = nil,
                          lineBreakMode: NSLineBreakMode? = nil, underlineStyle: NSUnderlineStyle? = nil,
                          strikeThroughStyle: NSUnderlineStyle? = nil) -> NSAttributedString {

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

    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }
}
