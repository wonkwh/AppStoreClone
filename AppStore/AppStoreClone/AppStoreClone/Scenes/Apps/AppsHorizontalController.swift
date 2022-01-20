//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import Nuke
import UIKit
import Models

class AppsHorizontalController: UIViewController {
    lazy var sectionCollectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        view.decelerationRate = .fast
        view.backgroundColor = .white
        view.register(cellType: AppListCell.self)
        view.dataSource = self
        view.delegate = self
        view.alwaysBounceHorizontal = true
        return view
    }()

    var appGroup: AppGroup?
    var didSelectHandler: ((FeedResult) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sectionCollectionView)
        sectionCollectionView.pinInSuperview()
    }
}

// MARK: - UICollectionViewDataSource

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

// MARK: - UICollectionViewDelegate

extension AppsHorizontalController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item] {
            didSelectHandler?(app)
        }
    }
}

let topBottomPadding: CGFloat = 12
let lineSpacing: CGFloat = 10

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return lineSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
}
