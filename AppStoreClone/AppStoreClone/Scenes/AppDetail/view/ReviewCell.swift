//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell, Reusable {
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))

    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))

    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))

    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0 ..< 5).forEach { _ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.withSize(24)
            arrangedSubviews.append(imageView)
        }

        arrangedSubviews.append(UIView())

        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()

    let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n", font: .systemFont(ofSize: 18), numberOfLines: 5)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)

        layer.cornerRadius = 16
        clipsToBounds = true

        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right

        VStackView(spacing: 12) {
            HStackView(spacing: 8) {
                titleLabel
                authorLabel
            }
            starsStackView
            bodyLabel
        }.withMargins(.init(top: 20, left: 20, bottom: 0, right: 20))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
