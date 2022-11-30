//
//  CollectionViewMiddleware.swift
//  ListKit
//
//  Created by zhtg on 2022/11/27.
//

import UIKit

open class CollectionViewMiddleware: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Middleware {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = self.items else { return 0 }
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let items = self.items {
            let item = items[indexPath.item]
            if var cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.identifier, for: indexPath) as? Cell {
                cell.item = item
                if let tbCell = cell as? UICollectionViewCell {
                    return tbCell
                }
            }
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let items = self.items else { return }
        let item = items[indexPath.item]
        if let handler = item.selectedHandler {
            handler(item)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let items = self.items else { return CGSize.zero }
        let item = items[indexPath.item]
        if let size = item.size {
            return size
        } else {
            return item.size(withViewWidth: collectionView.frame.size.width)
        }
    }
    
    public func reload(item: Item) {
        if let items = self.items,
           let index = items.firstIndex(where: { $0 === item }) {
            let indexPath = IndexPath(row: index, section: 0)
            if let tableView = view as? UICollectionView {
                tableView.reloadItems(at: [indexPath])
            }
        }
    }
}
