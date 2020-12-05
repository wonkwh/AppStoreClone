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

struct SearchResult: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
}
