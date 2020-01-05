//
//  UILabel+.swift
//  DesignKit-iOS
//
//  Created by kwanghyun.won on 2019/11/21.
//  Copyright © 2019 Vingle. All rights reserved.
//

import UIKit

public extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()

            style.lineSpacing = lineHeight
            let range = NSRange(location: 0, length: attributeString.length)
            attributeString.addAttribute(.paragraphStyle, value: style, range: range)
            self.attributedText = attributeString
        }
    }
}

public extension UILabel {

    /// attribute text 앞뒤에 이미지를 추가한다.
    /// - Parameters:
    ///   - text: 추가 텍스트
    ///   - image: 추가이미지
    ///   - imageBehindText: text뒤에 이미지가 올지 아닐지
    ///   - keepPreviousText: 기존 text를 유지할지 아닐지
    func addTextWithImage(
        text: String,
        image: UIImage,
        imageBehindText: Bool,
        keepPreviousText: Bool
    ) {
        let lAttachment = NSTextAttachment()
        lAttachment.image = image

        // 1pt = 1.32px
        let lFontSize = round(self.font.pointSize * 1.32)
        let lRatio = image.size.width / image.size.height

        lAttachment.bounds = CGRect(
            x: 0,
            y: ((self.font.capHeight - lFontSize) / 2).rounded(),
            width: lRatio * lFontSize,
            height: lFontSize
        )

        let lAttachmentString = NSAttributedString(attachment: lAttachment)

        if imageBehindText {
            let lStrLabelText: NSMutableAttributedString

            if keepPreviousText, let lCurrentAttributedString = self.attributedText {
                lStrLabelText = NSMutableAttributedString(attributedString: lCurrentAttributedString)
                lStrLabelText.append(NSMutableAttributedString(string: text))
            } else {
                lStrLabelText = NSMutableAttributedString(string: text)
            }

            lStrLabelText.append(lAttachmentString)
            self.attributedText = lStrLabelText
        } else {
            let lStrLabelText: NSMutableAttributedString

            if keepPreviousText, let lCurrentAttributedString = self.attributedText {
                lStrLabelText = NSMutableAttributedString(attributedString: lCurrentAttributedString)
                lStrLabelText.append(NSMutableAttributedString(attributedString: lAttachmentString))
                lStrLabelText.append(NSMutableAttributedString(string: text))
            } else {
                lStrLabelText = NSMutableAttributedString(attributedString: lAttachmentString)
                lStrLabelText.append(NSMutableAttributedString(string: text))
            }

            self.attributedText = lStrLabelText
        }
    }

    /// image가 추가되어 있는 attriute text를 제거
    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}
