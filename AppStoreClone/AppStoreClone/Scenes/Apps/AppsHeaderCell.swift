//
//  AppsHeaderCell.swift
//  AppStoreClone
//
//  Created by wonkwh on 2020/11/18.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

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
        label.text = "app title looks great"
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 2
        return label
    }()

    let imageView: UIImageView = {
        let view = UIImageView()
        view.setCorner(8)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        VStackView(alignment: .center, spacing: 12) {
            companyLabel
            titleLabel
            imageView.debug()
        }.withMargins(.init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}


