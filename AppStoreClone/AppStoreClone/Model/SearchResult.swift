//
//  SearchResult.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/09.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

struct SearchResultList: Decodable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchMusicResultList: Decodable {
    let resultCount: Int
    let results: [SearchMusicResult]
}

struct SearchResult: Decodable, Hashable {
    let identifier: UUID = UUID()
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float
    let artworkUrl60: String
    let screenshotUrls: [String]

    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }

    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else {
            return true
        }
        let lowcasedFilter = filterText.lowercased()
        return trackName.lowercased().contains(lowcasedFilter)
    }
}

struct SearchMusicResult: Decodable, Hashable {
    let identifier: UUID = UUID()

    let trackName: String
    let artistName: String
    let collectionCensoredName: String
    let artworkUrl60: String

    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }

    static func == (lhs: SearchMusicResult, rhs: SearchMusicResult) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else {
            return true
        }
        let lowcasedFilter = filterText.lowercased()
        return trackName.lowercased().contains(lowcasedFilter)
    }
}
