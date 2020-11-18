//
//  AppsHeaderHorizontalController.swift
//  AppStoreClone
//
//  Created by wonkwh on 2020/11/18.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    let appHeaderHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.pinInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class AppsHeaderHorizontalController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: self.view.frame.width - 48, height: view.frame.height)
        layout.sectionInset = .init(top: 12, left: 0, bottom: 0, right: 0)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.register(cellType: AppsHeaderCell.self)
        view.dataSource = self
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.pinInSuperview()

    }
}

extension AppsHeaderHorizontalController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AppsHeaderCell.self)
        return cell
    }
}
