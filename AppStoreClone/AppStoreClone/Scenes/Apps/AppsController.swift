//
//  AppsController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/17.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class AppsController: UIViewController {
    let headerId = "AppsPageHeaderId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: self.view.frame.width, height: 300)
        layout.sectionInset = .init(top: 12, left: 0, bottom: 0, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        
        view.register(cellType: AppGroupCell.self)
        view.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        view.dataSource = self
        view.alwaysBounceVertical = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.pinInSuperview()
    }
}

// MARK: -
extension AppsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AppGroupCell.self)
        return cell
    }
}

