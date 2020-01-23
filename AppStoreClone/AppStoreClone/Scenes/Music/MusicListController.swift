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

    private var allTrackResults = [SearchMusicResult]()
    lazy var dataSource = CollectionViewDiffableDataSource<Section, SearchMusicResult>(collectionView: collectionView) { (collectionView, indexPath, searchResult) in
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TrackCell.self)
        self.populate(cell, data: searchResult)

        //pagination
        if indexPath.item == self.allTrackResults.count - 1 {
            self.fetchData(searchTerm: "IU", offset: self.allTrackResults.count)
        }
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.register(cellType: TrackCell.self)
        fetchData(searchTerm: "IU")
    }

    private func fetchData(searchTerm: String, offset: Int = 0) {
        Service.shared.fetchItunesMusicApp(term: searchTerm, offset: offset) { (results, error) in
            if let error = error {
                dump(error)
                return
            }

            DispatchQueue.main.async {
                self.allTrackResults += results
                self.setup(dataSource: self.allTrackResults)
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
            Nuke.loadImage(with: url, into: cell.albumCoverImageView)
        }

        cell.trackNameLabel.text = data.trackName
        let releaseYear = data.releaseDate.components(separatedBy: "-").first
        cell.subtitleLabel.text = "\(data.artistName) - \(data.collectionCensoredName) - \(releaseYear ?? "") - \(data.primaryGenreName)"
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
