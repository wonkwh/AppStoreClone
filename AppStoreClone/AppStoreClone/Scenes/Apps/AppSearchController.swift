//
//  AppSearchController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/05.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Nuke

class AppSearchController: UICollectionViewController {

    private var appSearchResults = [SearchResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .systemBackground

        self.collectionView.register(cellType: SearchListCell.self)

        Service.shared.fetchItunesSearchApp(keyword: "facebook") { (results, error) in

            if let error = error {
                dump(error)
                return
            }

            DispatchQueue.main.async {
                self.appSearchResults = results
                self.collectionView.reloadData()
            }
        }
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - datasource
extension AppSearchController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appSearchResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SearchListCell.self)
        let app = appSearchResults[indexPath.row]
        if let url = URL(string: app.artworkUrl60),
            let screenshot1 = URL(string: app.screenshotUrls[0]) {
            Nuke.loadImage(with: url, into: cell.imageView)
            Nuke.loadImage(with: screenshot1, into: cell.screenshotImageView1)
        }

        if app.screenshotUrls.count > 1 {
            if let screenshot2 = URL(string: app.screenshotUrls[1]) {
                Nuke.loadImage(with: screenshot2, into: cell.screenshotImageView2)
            }
        }

        if app.screenshotUrls.count > 2 {
            if let screenshot3 = URL(string: app.screenshotUrls[2]) {
                Nuke.loadImage(with: screenshot3, into: cell.screenshotImageView3)
            }
        }


        cell.nameLabel.text = app.trackName
        cell.categoryLabel.text = app.primaryGenreName
        cell.ratingLabel.text = "\(app.averageUserRating)"
        return cell
    }
}

// MARK: - delegate
extension AppSearchController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AppSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}

