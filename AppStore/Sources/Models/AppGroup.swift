//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

public struct AppGroup: Decodable {
  public let feed: Feed
}

public struct Feed: Decodable {
  public let title: String
  public let results: [FeedResult]
}

public struct FeedResult: Decodable {
  public let id, name, artistName, artworkUrl100: String
}
