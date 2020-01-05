//
//  UITableView+.swift
//  DesignKit-iOS
//
//  Created by kwanghyun on 2019/11/19.
//  Copyright © 2019 vingle. All rights reserved.
//

import UIKit

public protocol Reusable {
    static var identifier: String { get }
}

public extension Reusable {
    /// By default, use the name of the class as String for its identifier
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UITableView {
    
    /// Reusable 프로토콜을 구현한 TableViewCell 의 register
    ///
    /// For Example:
    /// ```
    /// tableView.register(cellType: TableViewCell.self)
    /// ```
    ///
    /// - Parameter cellType: Reusable type cell
    func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }
    
    ///  Reusable 프로토콜을 구현한 TableViewCell 을 register후 reuse
    ///
    ///  For Example:
    ///  ```
    ///  let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TableViewCell.self)
    ///  ```
    ///
    /// - Parameters:
    ///   - indexPath: IndexPath
    ///   - cellType: Reusable TableCell type
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                 cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell \(cellType.identifier) matching type \(cellType.self).")
        }
        
        return cell
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath,
                                                 cellType: T.Type = T.self) -> T where T: Reusable {

        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell \(cellType.identifier) matching type \(cellType.self).")
        }

        return cell
    }
}