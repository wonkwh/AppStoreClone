//
//  AppListCell.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/17.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class AppListCell: UICollectionViewCell, Reusable {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.withSize(64)
        view.setCorner(12)
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Title"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let campanyLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .caption1)
        view.text = "Company"
        view.textColor = .lightGray
        return view
    }()

    private let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.setCorner(16)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        HStackView(alignment: .center, spacing: 16) {
            imageView
            VStackView(spacing: 10) {
                titleLabel
                campanyLabel
            }
            Spacer()
            getButton.withWidth(70)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
