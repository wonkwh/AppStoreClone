//
//  AppSearchController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/05.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Nuke
import DiffableDataSources

class AppSearchController: UICollectionViewController {

    enum Section {
        case main
    }

    private var allSearchResults = [SearchResult]()
    lazy var dataSource = CollectionViewDiffableDataSource<Section, SearchResult>(collectionView: collectionView) { (collectionView, indexPath, searchResult) in
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SearchListCell.self)
        self.populate(cell, data: searchResult)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.register(cellType: SearchListCell.self)

        setupSearchBar()
        fetchData(searchTerm: "facebook")
    }

    private func setupSearchBar() {
        definesPresentationContext = true
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func fetchData(searchTerm: String) {
        Service.shared.fetchItunesSearchApp(keyword: searchTerm) { (results, error) in
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

extension AppSearchController {
    func setup(dataSource: [SearchResult]) {
        var snapshot = DiffableDataSourceSnapshot<Section, SearchResult>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataSource)
        self.dataSource.apply(snapshot)
    }

    func populate(_ cell:SearchListCell , data: SearchResult) {
        if let url = URL(string: data.artworkUrl60),
            let screenshot1 = URL(string: data.screenshotUrls[0]) {
            Nuke.loadImage(with: url, into: cell.imageView)
            Nuke.loadImage(with: screenshot1, into: cell.screenshotImageView1)
        }

        if data.screenshotUrls.count > 1 {
            if let screenshot2 = URL(string: data.screenshotUrls[1]) {
                Nuke.loadImage(with: screenshot2, into: cell.screenshotImageView2)
            }
        }

        if data.screenshotUrls.count > 2 {
            if let screenshot3 = URL(string: data.screenshotUrls[2]) {
                Nuke.loadImage(with: screenshot3, into: cell.screenshotImageView3)
            }
        }


        cell.nameLabel.text = data.trackName
        cell.categoryLabel.text = data.primaryGenreName
        cell.ratingLabel.text = "\(data.averageUserRating)"
    }

    func search(filterText: String) {
        let filterd = allSearchResults.filter { (result) -> Bool in
            return result.contains(filterText)
        }

        setup(dataSource: filterd)
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

// MARK: - UISearchBarDelegate
extension AppSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchData(searchTerm: searchText)
    }
}
