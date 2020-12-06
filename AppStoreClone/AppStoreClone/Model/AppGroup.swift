//
//  AppGroup.swift
//  AppStoreClone
//
//  Created by wonkwh on 2020/11/22.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id, name, artistName, artworkUrl100: String
}
