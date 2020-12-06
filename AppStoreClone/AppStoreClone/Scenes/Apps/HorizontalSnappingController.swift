//
//  HorizontalSnappingController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/17.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// class BaseListController: UICollectionViewController {
//    init() {
//        super.init(collectionViewLayout: UICollectionViewFlowLayout())
//    }
//
//    @available(*, unavailable)
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
// }
