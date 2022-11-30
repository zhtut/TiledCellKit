//
//  Cell.swift
//  ModelTableView
//
//  Created by zhtg on 2022/10/17.
//

import UIKit

private var CellItemKey = "item"

public protocol Cell {
    var item: Item? { get set }
    func refresh(_ item: Item?)
    func reload()
}

public extension Cell {
    var item: Item? {
        get {
            if let item = objc_getAssociatedObject(self, &CellItemKey) as? Item {
                return item
            }
            return nil
        }
        set {
            newValue?.cell = self
            objc_setAssociatedObject(self, &CellItemKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            refresh(newValue)
        }
    }
    func refresh(_ item: Item?) { }
    func reload() {
        refresh(self.item)
    }
}
