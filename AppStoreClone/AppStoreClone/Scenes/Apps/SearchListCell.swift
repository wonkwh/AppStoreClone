//
//  SearchListCell.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/05.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class SearchListCell: UICollectionViewCell, Reusable {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.withSize(64)
        view.backgroundColor = .random
        view.setCorner(3)
        return view
    }()

    let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "AppName"
        return view
    }()

    let categoryLabel: UILabel = {
        let view = UILabel()
        view.text = "Category"
        return view
    }()

    let ratingLabel: UILabel = {
        let view = UILabel()
        view.text = "8.9"
        return view
    }()

    let screenshotImageView1: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        return view
    }()

    let screenshotImageView2: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        return view
    }()

    let screenshotImageView3: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        return view
    }()


    let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.90)
        button.setCorner(16)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        let screenShotStack = HStackView(spacing: 5) {
            screenshotImageView1
            screenshotImageView2
            screenshotImageView3
        }.distribution(justify: .fillEqually)

        VStackView(spacing: 10) {
            HStackView(alignment: .center, spacing: 12.0) {
                imageView
                VStackView() {
                    nameLabel
                    categoryLabel
                    ratingLabel
                }
                Spacer()
                getButton.withWidth(70)
            }
            screenShotStack
        }.withMargins(.allSides(16))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

