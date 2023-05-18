//
//  Middleware.swift
//  ListKit
//
//  Created by zhtg on 2022/11/27.
//

import UIKit

private var MiddlewareItemsKey = "itemsKey"
private var MiddlewareSectionsKey = "sectionsKey"
private var MiddlewareRegisterIdentifierKey = "registerIds"
private var MiddlewareViewKey = "view"

public protocol Middleware where Self: NSObject {
    var items: [Item] { get set }
    var sections: [Section] { get set }
    var view: (any List)? { get set }
    func reload(item: Item)
}

public extension Middleware {
    
    private var didRegisterIdentifiers: [String] {
        get {
            if let its = objc_getAssociatedObject(self, &MiddlewareRegisterIdentifierKey) as? [String] {
                return its
            }
            let items = [String]()
            objc_setAssociatedObject(self, &MiddlewareRegisterIdentifierKey, items, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return items
        }
        set {
            objc_setAssociatedObject(self, &MiddlewareRegisterIdentifierKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var items: [Item] {
        get {
            if let its = objc_getAssociatedObject(self, &MiddlewareItemsKey) as? [any Item] {
                return its
            }
            return []
        }
        set {
            objc_setAssociatedObject(self, &MiddlewareItemsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            var sections = [Section]()
            let hasSection = items.first(where: {$0 is Section})
            if hasSection == nil && isTableViewPlain {
                sections.append(DefaultSection(items: items))
            } else {
                var tempItems = [Item]()
                for item in newValue {
                    if item is Section || item is SpaceItem {
                        if tempItems.count > 0 {
                            sections.append(DefaultSection(items: tempItems))
                            tempItems.removeAll()
                        }
                        if let sec = item as? Section {
                            sections.append(sec)
                        } else if let space = item as? SpaceItem {
                            sections.append(DefaultSection(items: [space]))
                        }
                    } else {
                        tempItems.append(item)
                    }
                }
                sections.append(DefaultSection(items: tempItems))
            }
            self.sections = sections
        }
    }

    private var isTableViewPlain: Bool {
        if let view = view as? UITableView {
            return view.style == .plain
        }
        return false
    }

    var sections: [Section] {
        get {
            if let its = objc_getAssociatedObject(self, &MiddlewareSectionsKey) as? [Section] {
                return its
            }
            return []
        }
        set {
            objc_setAssociatedObject(self, &MiddlewareSectionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            for section in newValue {
                if let header = section.header {
                    registerItem(header)
                }
                if let footer = section.footer {
                    registerItem(footer)
                }
                for item in section.items {
                    registerItem(item)
                }
            }
            view?.reload()
        }
    }

    func registerItem(_ item: Item) {
        if !didRegisterIdentifiers.contains(item.identifier) {
            view?.registerItem(item)
            didRegisterIdentifiers.append(item.identifier)
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

public extension Middleware {

    var sectionCount: Int {
        sections.count
    }

    func sectionAt(_ index: Int) -> Section? {
        guard sections.count > index else {
            return nil
        }
        let section = sections[index]
        return section
    }

    func numberOfItems(in section: Int) -> Int {
        guard let section = sectionAt(section) else {
            return 0
        }
        return section.items.count
    }

    func itemAt(_ indexPath: IndexPath) -> Item? {
        guard sections.count > indexPath.section else {
            return nil
        }
        let section = sections[indexPath.section]
        guard section.items.count > indexPath.row else {
            return nil
        }
        return section.items[indexPath.row]
    }
}
