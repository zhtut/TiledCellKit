//
//  Middleware.swift
//  ListKit
//
//  Created by zhtg on 2022/11/27.
//

import UIKit

private var MiddlewareItemsKey = "itemsKey"
private var MiddlewareRegisterCellsKey = "registerCells"
private var MiddlewareViewKey = "view"

public protocol Middleware where Self: NSObject {
    var items: [any Item]? { get set }
    var view: (any List)? { get set }
    func reload(item: any Item)
}

public extension Middleware {
    
    private var didRegisterCells: [String] {
        get {
            if let its = objc_getAssociatedObject(self, &MiddlewareRegisterCellsKey) as? [String] {
                return its
            }
            let items = [String]()
            objc_setAssociatedObject(self, &MiddlewareRegisterCellsKey, items, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return items
        }
        set {
            objc_setAssociatedObject(self, &MiddlewareRegisterCellsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var items: [any Item]? {
        get {
            if let its = objc_getAssociatedObject(self, &MiddlewareItemsKey) as? [any Item] {
                return its
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &MiddlewareItemsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let items = newValue {
                for item in items {
                    if !didRegisterCells.contains(item.identifier) {
                        view?.registerItem(item)
                        didRegisterCells.append(item.identifier)
                    }
                }
            }
            view?.reload()
        }
    }
    
    var view: (any List)? {
        get {
            if let weakObj = objc_getAssociatedObject(self, &MiddlewareViewKey) as? WeakObject,
               let cell = weakObj.object as? (any List) {
                return cell
            }
            return nil
        }
        set {
            let weakObj = WeakObject()
            if let obj = newValue as? AnyObject {
                weakObj.object = obj
            }
            objc_setAssociatedObject(self, &MiddlewareViewKey, weakObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
