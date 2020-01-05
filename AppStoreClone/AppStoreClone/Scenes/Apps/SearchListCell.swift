//
//  SearchListCell.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/05.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class SearchListCell: UICollectionViewCell {

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


    let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .lightGray
        button.setCorner(10)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow

        HStackView(alignment: .center, spacing: 12) {
            imageView
            VStackView() {
                nameLabel
                categoryLabel
                ratingLabel
            }
            Spacer()
            getButton.withWidth(70)
        }.withMargins(.allSides(horizontal: 5, vertical: 10))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

