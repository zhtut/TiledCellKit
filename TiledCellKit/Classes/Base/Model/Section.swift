//
//  Section.swift
//  TiledCellKit
//
//  Created by zhtg on 2023/5/5.
//

import Foundation
import ObjectiveC

private var SectionHeaderKey = 0
private var SectionFooterKey = 0

public protocol Section: NSObject, Model {
    var header: Item? { get set }
    var footer: Item? { get set }
    var items: [Item] { get set }
    init(items: [Item])
}

public extension Section {
    var header: Item? {
        get {
            objc_getAssociatedObject(self, &SectionHeaderKey) as? Item
        }
        set {
            objc_setAssociatedObject(self, &SectionHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var footer: Item? {
        get {
            objc_getAssociatedObject(self, &SectionFooterKey) as? Item
        }
        set {
            objc_setAssociatedObject(self, &SectionFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
