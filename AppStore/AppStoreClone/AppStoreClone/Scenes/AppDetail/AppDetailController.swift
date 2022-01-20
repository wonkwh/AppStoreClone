//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Models
import ApiClient

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    fileprivate let appId: String

    // dependency injection constructor
    init(appId: String) {
        self.appId = appId
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var app: SearchResult?
    var reviews: Reviews?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white

        collectionView.register(cellType: AppDetailCell.self)
        collectionView.register(cellType: PreviewCell.self)
        collectionView.register(cellType: ReviewRowCell.self)

        navigationItem.largeTitleDisplayMode = .never

        fetchData()
    }

    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)&country=kr"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResultList?, _) in
            let app = result?.results.first
            self.app = app
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=kr&cc=kr"
        Service.shared.fetchGenericJSONData(urlString: reviewsUrl) { (reviews: Reviews?, err) in
            if let err = err {
                debugPrint("Failed to decode reviews:", err)
                return
            }

            self.reviews = reviews
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AppDetailCell.self)
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PreviewCell.self)
            cell.horizontalController.app = app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ReviewRowCell.self)
            cell.reviewsController.reviews = reviews
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var height: CGFloat = 280

        if indexPath.item == 0 {
            // calculate the necessary size for our cell somehow
            let cell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1_000))
            cell.app = app
            cell.layoutIfNeeded()

            let estimatedSize = cell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1_000))
            height = estimatedSize.height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 280
        }

        return .init(width: view.frame.width, height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
}
