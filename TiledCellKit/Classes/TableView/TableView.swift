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
        if let cellClass = item.cellClass as? UITableViewCell.Type {
            register(cellClass, forCellReuseIdentifier: item.identifier)
        }
    }
    public func reload() {
        reloadData()
    }
    public func setDelegate() {
        delegate = mid
        dataSource = mid
    }
}
