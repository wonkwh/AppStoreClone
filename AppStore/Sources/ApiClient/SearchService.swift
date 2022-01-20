//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation
import Models
import Get

public class Service {
    public static let shared = Service() // singleton

    public func fetchItunesSearchApp(keyword: String, _ completion: @escaping ([SearchResult], Error?) -> ()) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(keyword)&entity=software") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                debugPrint("Failed to fetch apps:", error)
                completion([], error)
            }

            guard let data = data else { return }
            do {
                let results = try JSONDecoder().decode(SearchResultList.self, from: data)
                completion(results.results, nil)
            } catch let jsonError {
                debugPrint("Failed to decode json:", jsonError)
                completion([], jsonError)
            }
        }.resume()
    }

    public func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/kr/ios-apps/top-grossing/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }

    public func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchAppGroup(
            urlString: "https://rss.itunes.apple.com/api/v1/kr/ios-apps/new-games-we-love/all/50/explicit.json",
            completion: completion
        )
    }

    // generic helper
    public func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, err in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                // success
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    // declare my generic json public function here
    public func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, err in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}