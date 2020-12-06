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
        layout.headerReferenceSize = .init(width: self.view.frame.width, height: 300)
        layout.sectionInset = .init(top: 12, left: 0, bottom: 0, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.register(cellType: AppGroupCell.self)
        view.register(
            AppsPageHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerId
        )
        view.dataSource = self
        view.alwaysBounceVertical = true
        return view
    }()

    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.pinInSuperview()

        view.addSubview(activityIndicatorView)
        activityIndicatorView.pinInSuperview()

        fetchData()
    }

    var groups = [AppGroup]()

    fileprivate func fetchData() {
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?

        // help you sync your data fetches together
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        Service.shared.fetchGames { appGroup, _ in
            dispatchGroup.leave()
            group1 = appGroup
        }

        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { appGroup, _ in
            dispatchGroup.leave()
            group2 = appGroup
        }

        dispatchGroup.enter()
        let urlString = "https://rss.itunes.apple.com/api/v1/kr/ios-apps/top-free/all/25/explicit.json"
        Service.shared
            .fetchAppGroup(urlString: urlString) { appGroup, _ in
                dispatchGroup.leave()
                group3 = appGroup
            }

        // completion
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()

            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension AppsController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AppGroupCell.self)

        let appGroup = groups[indexPath.item]

        cell.titleLabel.text = appGroup.feed.title
        cell.appsHorizontalController.appGroup = appGroup
        cell.appsHorizontalController.sectionCollectionView.reloadData()

        cell.appsHorizontalController.didSelectHandler = { [weak self] feedResult in
            let controller = AppDetailController(appId: feedResult.id)
            controller.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(controller, animated: true)
        }

        return cell
    }
}
