//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

public struct Reviews: Decodable {
    public let feed: ReviewFeed
}

public struct ReviewFeed: Decodable {
    public let entry: [Entry]
}

public struct Entry: Decodable {
    public let author: Author
    public let title: Label
    public let content: Label

    public let rating: Label

    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

public struct Author: Decodable {
    public let name: Label
}

public struct Label: Decodable {
    public let label: String
}
