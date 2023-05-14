//
//  List.swift
//  ModelTableView
//
//  Created by zhtg on 2022/10/17.
//

import UIKit

var MiddlewareKey = "middleware"

public protocol List {
    associatedtype AnyMiddleware: Middleware
    /// 代理中间件
    var mid: AnyMiddleware { get set }
    func registerItem(_ item: Item)
    func setDelegate()
    /// 重新对cell进行赋值
    func reload()
    /// 用Item刷新Cell
    func reload(item: Item)
}

public extension List {
    /// 代理中间件
    var mid: AnyMiddleware {
        get {
            if let mid = objc_getAssociatedObject(self, &MiddlewareKey) as? AnyMiddleware {
                return mid
            }
            if let tableView = self as? UITableView {
                if tableView.style == .plain {
                    tableView.estimatedRowHeight = 44
                    tableView.estimatedSectionFooterHeight = 0
                    tableView.estimatedSectionHeaderHeight = 0
                    tableView.sectionFooterHeight = 0
                    tableView.sectionHeaderHeight = 0
                }
            }
            let new = AnyMiddleware()
            setNewMid(new)
            return new
        }
        set {
            setNewMid(newValue)
        }
    }
    private func setNewMid(_ new: AnyMiddleware) {
        new.view = self
        objc_setAssociatedObject(self, &MiddlewareKey, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        setDelegate()
    }
    /// 刷新某个Item
    func reload(item: any Item) {
        mid.reload(item: item)
    }
}
