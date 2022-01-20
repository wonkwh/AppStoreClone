//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Models
import ApiClient

class AppSearchController: UICollectionViewController {
  fileprivate let cellId = "id1234"
  
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  
  fileprivate let enterSearchTermLabel: UILabel = {
    let label = UILabel()
    label.text = "Please enter search term above..."
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(cellType: SearchListCell.self)
    collectionView.addSubview(enterSearchTermLabel)
    //        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
    
    setupSearchBar()
  }
  
  fileprivate func setupSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }
  
  var timer: Timer?
  fileprivate var appResults = [SearchResult]()
  
  fileprivate func fetchITunesApps() {
    Service.shared.fetchItunesSearchApp(keyword: "Twitter") { results, err in
      
      if let err = err {
        debugPrint("Failed to fetch apps:", err)
        return
      }
      
      self.appResults = results
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    enterSearchTermLabel.isHidden = !appResults.isEmpty
    return appResults.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SearchListCell.self)
    cell.appResult = appResults[indexPath.item]
    return cell
  }
}

// MARK: - UISearch

extension AppSearchController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // introduce some delay before performing the search
    // throttling the search
    
    timer?.invalidate()
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
      Service.shared.fetchItunesSearchApp(keyword: searchText) { results, _ in
        self.appResults = results
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    })
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppSearchController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return .init(width: view.frame.width, height: 350)
  }
}
