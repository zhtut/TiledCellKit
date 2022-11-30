//
//  Item.swift
//  ModelTableView
//
//  Created by zhtg on 2022/10/17.
//

import UIKit

private var ItemCellKey = "cell"
private var ItemSelectedHandlerKey = "selectedHandler"
private var TableViewItemCellHeightKey = "height"
private var CollectionViewItemSizeKey = "size"

public protocol Item: NSObject {
    /// must
    var cellClass: Cell.Type { get }
    
    /// optional
    var cell: Cell? { get set }
    var identifier: String { get }
    func reload()
    var selectedHandler: ((_ item: Item) -> Void)? { get set }
    
    // tableView
    var height: Double? { get set }
    func height(withViewWidth width: Double) -> Double
    
    // collectionView
    var size: CGSize? { get set }
    func size(withViewWidth width: Double) -> CGSize
}

public extension Item {
    var cell: Cell? {
        get {
            if let weakObj = objc_getAssociatedObject(self, &ItemCellKey) as? WeakObject,
               let cell = weakObj.object as? Cell {
                return cell
            }
            return nil
        }
        set {
            let weakObj = WeakObject()
            if let obj = newValue as? AnyObject {
                weakObj.object = obj
            }
            objc_setAssociatedObject(self, &ItemCellKey, weakObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var identifier: String {
        "\(cellClass.self)"
    }
    func reload() {
        cell?.reload()
    }
    var selectedHandler: ((_ item: any Item) -> Void)? {
        get {
            if let handler = objc_getAssociatedObject(self, &ItemSelectedHandlerKey) as? ((_ item: any Item) -> Void) {
                return handler
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &ItemSelectedHandlerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension Item {
    var height: Double? {
        get {
            objc_getAssociatedObject(self, &TableViewItemCellHeightKey) as? Double
        }
        set {
            objc_setAssociatedObject(self, &TableViewItemCellHeightKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func height(withViewWidth width: Double) -> Double {
        return 44.0
    }
}

public extension Item {
    var size: CGSize? {
        get {
            objc_getAssociatedObject(self, &CollectionViewItemSizeKey) as? CGSize
        }
        set {
            objc_setAssociatedObject(self, &CollectionViewItemSizeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func size(withViewWidth width: Double) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
