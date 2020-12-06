//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import Nuke
import UIKit

class MultipleAppCell: UICollectionViewCell, Reusable {
    var app: FeedResult! {
        didSet {
            nameLabel.text = app.name
            companyLabel.text = app.artistName
            if let url = URL(string: app.artworkUrl100) {
                Nuke.loadImage(with: url, into: imageView)
            }
        }
    }

    let imageView = UIImageView(cornerRadius: 8)

    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))

    let getButton = UIButton(title: "GET")

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.backgroundColor = .purple
        imageView.withWidth(64)
        imageView.withHeight(64)

        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.withWidth(80)
        getButton.withHeight(32)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.layer.cornerRadius = 32 / 2

        let stackView =
            UIStackView(arrangedSubviews: [
                imageView,
                VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4),
                getButton
            ])
        stackView.spacing = 16

        stackView.alignment = .center

        addSubview(stackView)
        stackView.fillSuperview()

        addSubview(separatorView)
        separatorView.anchor(
            top: nil,
            leading: nameLabel.leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: -8, right: 0),
            size: .init(width: 0, height: 0.5)
        )
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
