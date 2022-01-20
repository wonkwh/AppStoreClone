//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Swifty

class AppsHeaderCell: UICollectionViewCell, Reusable {
    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Vingle"
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Keeping up with friends is faster than ever"
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 2
        return label
    }()

    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.setCorner(8)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.random

        let stackview = UIStackView(arrangedSubviews: [
            companyLabel,
            titleLabel,
            imageView.debug()
        ])

        stackview.alignment = .fill
        stackview.spacing = 12
        stackview.axis = .vertical
        addSubview(stackview)
        // stackview.withSize(16)

//        VStackView(spacing: 12) {
//            companyLabel
//            titleLabel
//        }.padTop(16)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
