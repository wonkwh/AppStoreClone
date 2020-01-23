//
//  MusicListController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/23.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Nuke
import DiffableDataSources

class MusicListController: UICollectionViewController {

    enum Section {
        case main
    }

    private var allSearchResults = [SearchMusicResult]()
    lazy var dataSource = CollectionViewDiffableDataSource<Section, SearchMusicResult>(collectionView: collectionView) { (collectionView, indexPath, searchResult) in
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TrackCell.self)
        self.populate(cell, data: searchResult)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.register(cellType: TrackCell.self)
        fetchData(searchTerm: "IU")
    }

    private func fetchData(searchTerm: String) {
        Service.shared.fetchItunesMusicApp { (results, error) in
            if let error = error {
                dump(error)
                return
            }

            DispatchQueue.main.async {
                self.allSearchResults = results
                self.setup(dataSource: results)
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

extension MusicListController {
    func setup(dataSource: [SearchMusicResult]) {
        var snapshot = DiffableDataSourceSnapshot<Section, SearchMusicResult>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataSource)
        self.dataSource.apply(snapshot)
    }

    func populate(_ cell:TrackCell , data: SearchMusicResult) {

        if let url = URL(string: data.artworkUrl60) {
            Nuke.loadImage(with: url, into: cell.imageView)
        }

        cell.nameLabel.text = data.artistName
        cell.subtitleLabel.text = "\(data.trackName) - \(data.collectionCensoredName)"
    }
}

// MARK: - delegate
extension MusicListController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MusicListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 88)
    }
}
