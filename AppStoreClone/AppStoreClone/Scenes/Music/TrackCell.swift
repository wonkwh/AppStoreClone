//
//  TrackCell.swift
//  AppStoreClone
//
//  Created by ios_dev on 2020/01/23.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell, Reusable {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.withSize(64)
        view.setCorner(12)
        return view
    }()

    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.text = "The Way I Loved You"
        return view
    }()

    let subtitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.text = "Tayor Swift - Reputation - Pop"
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        contentView.HStackView(alignment: .center, spacing: 12.0) {
            imageView
            VStackView() {
                nameLabel
                subtitleLabel
            }
            Spacer()
        }.withMargins(.allSides(12))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

