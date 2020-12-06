//  ReviewRowCell.swift
//  AppStoreClone
//
//  Created by wonkwh on 2020/01/19.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell, Reusable {
    let reviewsRatingsLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))
    let reviewsController = ReviewsController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let view = reviewsController.view!
        VStackView(spacing: 10) {
            reviewsRatingsLabel.withHeight(24)
            view
        }.withMargins(.init(top: 20, left: 20, bottom: 0, right: 20))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
