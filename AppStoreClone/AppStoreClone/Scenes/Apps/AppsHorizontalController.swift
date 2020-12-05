//
//  AppsHorizontalController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won on 2020/01/17.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Nuke

class AppsHorizontalController: UIViewController {
    lazy var sectionCollectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: self.view.frame.width - 48,
                                height: 65)
        layout.minimumLineSpacing = 10
        layout.sectionInset = .init(horizontal: 12, vertical: 16)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.decelerationRate = .fast
        view.backgroundColor = .white
        view.register(cellType: AppListCell.self)
        view.dataSource = self
        view.alwaysBounceHorizontal = true
        return view
    }()

    var appGroup: AppGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sectionCollectionView)
        sectionCollectionView.pinInSuperview()
    }
}

extension AppsHorizontalController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AppListCell.self)
        let app = appGroup?.feed.results[indexPath.item]
        cell.titleLabel.text = app?.name
        cell.campanyLabel.text = app?.artistName
        if let url = URL(string: app?.artworkUrl100 ?? "") {
            Nuke.loadImage(with: url, into: cell.imageView)
        }

        return cell
    }
}
