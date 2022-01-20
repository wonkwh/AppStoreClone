//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Models

class TodayCell: BaseTodayCell, Reusable {
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description

            backgroundColor = todayItem.backgroundColor
            backgroundView?.backgroundColor = todayItem.backgroundColor
        }
    }

    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))

    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))

    let descriptionLabel = UILabel(
        text: "All the tools and apps you need to intelligently organize your life the right way.",
        font: .systemFont(ofSize: 16),
        numberOfLines: 3
    )

    var topConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        layer.cornerRadius = 16

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.withSize(240)
        imageView.centerInSuperview()
//        imageView.centerInSuperview(size: .init(width: 240, height: 240))

        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, imageContainerView, descriptionLabel
        ], spacing: 8)
        addSubview(stackView)

        stackView.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 24, bottom: 24, right: 24)
        )
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint.isActive = true
    }
}
