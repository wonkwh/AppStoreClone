//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

public struct SearchResultList: Decodable {
    public let resultCount: Int
    public let results: [SearchResult]
}

public struct SearchResult: Decodable {
    public let trackId: Int
    public let trackName: String
    public let primaryGenreName: String
    public var averageUserRating: Float?
    public let screenshotUrls: [String]
    public let artworkUrl100: String
    public var formattedPrice: String?
    public let description: String
    public var releaseNotes: String?
}
