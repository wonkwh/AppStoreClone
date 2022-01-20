//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

public struct TodayItem {
  public  init(
    category: String,
    title: String,
    image: UIImage,
    description: String,
    backgroundColor: UIColor,
    cellType: TodayItem.CellType,
    apps: [FeedResult]
  ) {
    self.category = category
    self.title = title
    self.image = image
    self.description = description
    self.backgroundColor = backgroundColor
    self.cellType = cellType
    self.apps = apps
  }
  
  public let category: String
  public let title: String
  public let image: UIImage
  public let description: String
  public let backgroundColor: UIColor
  
  // enum
  public let cellType: CellType
  
  public let apps: [FeedResult]
  
  public enum CellType: String {
    case single, multiple
  }
}
