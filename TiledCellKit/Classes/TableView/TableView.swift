//
//  TableView.swift
//  ListKit
//
//  Created by zhtg on 2022/11/27.
//

import UIKit

extension UITableView: List {

    public typealias AnyMiddleware = TableViewMiddleware
    
    public func registerItem(_ item: any Item) {
        if let viewClass = item.viewClass as? UITableViewHeaderFooterView.Type {
            register(viewClass, forHeaderFooterViewReuseIdentifier: item.identifier)
        }
        if let viewClass = item.viewClass as? UITableViewCell.Type {
            register(viewClass, forCellReuseIdentifier: item.identifier)
        }
    }

    public func reload() {
        reloadData()
    }

    public func setDelegate() {
        delegate = mid
        dataSource = mid
        if style == .plain {
            estimatedRowHeight = CGFloat.zero
            estimatedSectionFooterHeight = CGFloat.zero
            estimatedSectionHeaderHeight = CGFloat.zero
        }
    }
}


public extension UITableView {

    /// 反选已选中行
    func deselectSelectedRows() {
        if let indexPaths = indexPathsForSelectedRows {
            indexPaths.forEach { indexPath in
                deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
