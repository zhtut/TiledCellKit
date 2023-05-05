//
//  CollectionView.swift
//  ListKit
//
//  Created by zhtg on 2022/11/27.
//

import UIKit

extension UICollectionView: List {
    
    public typealias AnyMiddleware = CollectionViewMiddleware
    
    public func registerItem(_ item: any Item) {
        if let viewClass = item.viewClass as? UICollectionViewCell.Type {
            register(viewClass, forCellWithReuseIdentifier: item.identifier)
        }
    }
    public func reload() {
        reloadData()
    }
    public func setDelegate() {
        delegate = mid
        dataSource = mid
    }
}
