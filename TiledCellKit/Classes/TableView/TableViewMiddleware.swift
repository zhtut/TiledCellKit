//
//  TableViewMiddleware.swift
//  ListKit
//
//  Created by zhtg on 2022/11/27.
//

import UIKit

open class TableViewMiddleware: NSObject, UITableViewDelegate, UITableViewDataSource, Middleware {

    open func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = itemAt(indexPath) else {
            return CGFloat.zero
        }
        if let height = item.height {
            return height
        } else {
            return item.height(withViewWidth: tableView.frame.size.width)
        }
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let section = sectionAt(section),
           let header = section.header {
            if let height = header.height {
                return height
            } else {
                return header.height(withViewWidth: tableView.frame.size.width)
            }
        }
        return CGFloat.zero
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let section = sectionAt(section),
           let footer = section.footer {
            if let height = footer.height {
                return height
            } else {
                return footer.height(withViewWidth: tableView.frame.size.width)
            }
        }
        return CGFloat.zero
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = itemAt(indexPath) {
            if var cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
                as? Reusable {
                cell.item = item
                if let tbCell = cell as? UITableViewCell {
                    return tbCell
                }
            }
        }

        return UITableViewCell()
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let section = sectionAt(section),
           let header = section.header,
           let headerFooterClass = header.viewClass as? UITableViewHeaderFooterView.Type {
            var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.identifier)
            if headerView == nil {
                headerView = headerFooterClass.init(reuseIdentifier: header.identifier)
            }
            if var reusable = headerView as? Reusable {
                reusable.item = header
            }
            return headerView
        }
        return nil
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let section = sectionAt(section),
           let footer = section.footer,
           let headerFooterClass = footer.viewClass as? UITableViewHeaderFooterView.Type {
            var footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.identifier)
            if footerView == nil {
                footerView = headerFooterClass.init(reuseIdentifier: footer.identifier)
            }
            if var reusable = footerView as? Reusable {
                reusable.item = footer
            }
            return footerView
        }
        return nil
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = itemAt(indexPath),
           let handler = item.selectedHandler {
            handler(item)
        }
    }

    open func reload(section: Section) {
        if let index = sections.firstIndex(where: { $0 === section }),
           let tableView = view as? UITableView {
            tableView.reloadSections(IndexSet(integer: index), with: .none)
        }
    }

    open func reload(item: any Item) {
        for (index, section) in sections.enumerated() {
            let items = section.items
            if let index = items.firstIndex(where: { $0 === item }) {
                let indexPath = IndexPath(row: index, section: index)
                if let tableView = view as? UITableView {
                    tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
        }
    }
}
