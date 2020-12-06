//
//  AppDetailCell.swift
//  AppStoreClone
//
//  Created by wonkwh on 2020/01/19.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Nuke
import UIKit

class AppDetailCell: UICollectionViewCell, Reusable {
    var app: SearchResult? {
        didSet {
            guard let app = app else {
                return
            }
            nameLabel.text = app.trackName
            releaseNotesLabel.text = app.releaseNotes
            if let url = URL(string: app.artworkUrl100) {
                Nuke.loadImage(with: url, into: appIconImageView)
            }
            priceButton.setTitle(app.formattedPrice, for: .normal)
        }
    }

    let appIconImageView = UIImageView(cornerRadius: 16)

    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)

    let priceButton = UIButton(title: "$4.99")

    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))

    let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 18), numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)

        appIconImageView.backgroundColor = .red
        appIconImageView.withSize(140)

        priceButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 0.937254902, alpha: 1)
        priceButton.withHeight(32)

        priceButton.layer.cornerRadius = 32 / 2
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.withWidth(80)

        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [
                    nameLabel,
                    UIStackView(arrangedSubviews: [priceButton, UIView()]),
                    UIView()
                ], spacing: 12)
            ], customSpacing: 20),
            whatsNewLabel,
            releaseNotesLabel
        ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
