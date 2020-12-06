//
//  PreviewScreenshotsController.swift
//  AppStoreClone
//
//  Created by wonkwh on 2020/01/19.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Nuke
import UIKit

class ScreenshotCell: UICollectionViewCell, Reusable {
    let imageView = UIImageView(cornerRadius: 12)

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.backgroundColor = .purple
        addSubview(imageView)
        imageView.pinInSuperview()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

class PreviewScreenshotsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    var app: SearchResult? {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(cellType: ScreenshotCell.self)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ScreenshotCell.self)
        if let screenshotUrl = URL(string: (app?.screenshotUrls[indexPath.item])!) {
            Nuke.loadImage(with: screenshotUrl, into: cell.imageView)
        }

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
