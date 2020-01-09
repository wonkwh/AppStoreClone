//
//  SearchService.swift
//  AppStoreClone
//
//  Created by ios_dev on 2020/01/09.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()

    func fetchItunesSearchApp(keyword: String, _ completion: @escaping ([SearchResult], Error?) -> ()) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(keyword)&entity=software") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion([], error)
            }

            guard let data = data  else { return }
            do {
                let results = try JSONDecoder().decode(SearchResultList.self, from: data)
                completion(results.results, nil)
            } catch let jsonError {
                completion([], jsonError)
            }
        }.resume()
    }
}

