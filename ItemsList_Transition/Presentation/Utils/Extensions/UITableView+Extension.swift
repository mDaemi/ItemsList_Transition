//
//  UITableView+Extension.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import UIKit

extension UITableView {
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier,
                                                  for: indexPath) as? Cell else {
                                                    fatalError("Error for cell id: \(identifier) at \(indexPath))")
        }
        return cell
    }
}
