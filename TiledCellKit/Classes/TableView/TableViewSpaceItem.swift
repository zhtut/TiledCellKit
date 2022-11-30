//
//  SpaceItem.swift
//  ListKit
//
//  Created by zhtg on 2022/10/18.
//

import UIKit

/// 空白的一个Item
open class TableViewSpaceItem: NSObject, Item {
    public var cellClass: Cell.Type = TableViewSpaceCell.self
    public func height(withViewWidth width: Double) -> Double {
        return 8.0
    }
}

/// 空白的cell
open class TableViewSpaceCell: BaseTableViewCell, Cell {
    open override func setup() {
        super.setup()
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
