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

public protocol TableViewHeight {
    // tableView
    var height: Double? { get set }
    func height(withViewWidth width: Double) -> Double
}

public protocol CollectionViewSize {
    // collectionView
    var size: CGSize? { get set }
    func size(withViewWidth width: Double) -> CGSize
}

/// 基础模型，Cell
public protocol Item: NSObject, TableViewHeight, CollectionViewSize, Model {
    /// must
    var viewClass: Reusable.Type { get }
}

public extension Item {
    var view: Reusable? {
        get {
            if let weakObj = objc_getAssociatedObject(self, &ItemCellKey) as? WeakObject,
               let cell = weakObj.object as? Reusable {
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
        "\(viewClass.self)"
    }
    func reload() {
        view?.reload()
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
