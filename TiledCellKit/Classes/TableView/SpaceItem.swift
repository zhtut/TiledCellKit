//
//  SpaceItem.swift
//  ListKit
//
//  Created by zhtg on 2022/10/18.
//

import UIKit

/// 空白的一个Item
open class SpaceItem: NSObject, Item {
    public var viewClass: Reusable.Type = SpaceCell.self
    public func height(withViewWidth width: Double) -> Double {
        return height ?? 8.0
    }
    public init(height: CGFloat = 8.0) {
        super.init()
        self.height = height
    }
}

/// 空白的cell
open class SpaceCell: BaseTableViewCell, Reusable {
    open override func setup() {
        super.setup()
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
