//
//  AppGroupCell.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/17.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class AppGroupCell: UICollectionViewCell, Reusable {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Section Title"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let appsHorizontalController = AppsHorizontalController()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        let view = appsHorizontalController.view.debug()
        VStackView(spacing: 10) {
            titleLabel
            view
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
