//
//  DefaultSection.swift
//  TiledCellKit
//
//  Created by zhtg on 2023/5/5.
//

import Foundation

open class DefaultSection: NSObject, Section {

    open var items: [Item]

    required public init(items: [Item]) {
        self.items = items
        super.init()
    }
}
