//
//  TableViewMiddleware.swift
//  ListKit
//
//  Created by zhtg on 2022/11/27.
//

import UIKit

open class TableViewMiddleware: NSObject, UITableViewDelegate, UITableViewDataSource, Middleware {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let items = self.items else { return 0 }
        let item = items[indexPath.row]
        if let height = item.height {
            return height
        } else {
            return item.height(withViewWidth: tableView.frame.size.width)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.items else { return 0 }
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let items = self.items {
            let item = items[indexPath.row]
            if var cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as? Cell {
                cell.item = item
                if let tbCell = cell as? UITableViewCell {
                    return tbCell
                }
            }
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = self.items else { return }
        let item = items[indexPath.row]
        if let handler = item.selectedHandler {
            handler(item)
        }
    }
    public func reload(item: any Item) {
        if let items = self.items,
           let index = items.firstIndex(where: { $0 === item }) {
            let indexPath = IndexPath(row: index, section: 0)
            if let tableView = view as? UITableView {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}
