//
//  AppsHorizontalController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won on 2020/01/17.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class AppsHorizontalController: UIViewController {
    lazy var sectionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: self.view.frame.width - 40,
                                height: 65)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.backgroundColor = .random
        view.register(cellType: AppListCell.self)
        view.dataSource = self
        view.alwaysBounceHorizontal = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sectionCollectionView)
        sectionCollectionView.pinInSuperview()
    }
}

extension AppsHorizontalController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AppListCell.self)
        return cell
    }
}

class AppListCell: UICollectionViewCell, Reusable {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Title"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .random

        VStackView(spacing: 10) {
            titleLabel
            Spacer()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
