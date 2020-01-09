//
//  AppSearchController.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/05.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

struct SearchResultList: Decodable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let trackName: String
    let primaryGenreName: String
}

class AppSearchController: UICollectionViewController {

    private var appSearchResults = [SearchResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .systemBackground

        self.collectionView.register(cellType: SearchListCell.self)
        fetchItunesSearchApp("facebook")
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fetchItunesSearchApp(_ keyword: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(keyword)&entity=software") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("fetch error:", error)
            }

            guard let data = data  else { return }
            do {
                let results = try JSONDecoder().decode(SearchResultList.self, from: data)
                self.appSearchResults = results.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let jsonError {
                print("error:", jsonError)
            }
        }.resume()
    }
}

// MARK: - datasource
extension AppSearchController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appSearchResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SearchListCell.self)
        cell.nameLabel.text = appSearchResults[indexPath.row].trackName
        cell.categoryLabel.text = appSearchResults[indexPath.row].primaryGenreName
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

