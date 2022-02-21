//
//  UITableView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 20/02/2022.
//

import UIKit
public extension UITableView {

    func dequeue<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.identifier, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.identifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }

}
