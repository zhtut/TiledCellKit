//
//  CollectionViewMiddleware.swift
//  ListKit
//
//  Created by zhtg on 2022/11/27.
//

import UIKit

open class CollectionViewMiddleware: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Middleware {
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionCount
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = itemAt(indexPath) {
            if var cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.identifier, for: indexPath)
                as? Reusable {
                cell.item = item
                if let ctCell = cell as? UICollectionViewCell {
                    return ctCell
                }
            }
        }

        return UICollectionViewCell()
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = itemAt(indexPath),
           let handler = item.selectedHandler {
            handler(item)
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = itemAt(indexPath) else {
            return CGSize.zero
        }
        if let size = item.size {
            return size
        } else {
            return item.size(withViewWidth: collectionView.frame.size.width)
        }
    }

    open func reload(section: Section) {
        if let index = sections.firstIndex(where: { $0 === section }),
           let collectionView = view as? UICollectionView {
            collectionView.reloadSections(IndexSet(integer: index))
        }
    }

    open func reload(item: any Item) {
        for (_, section) in sections.enumerated() {
            let items = section.items
            if let index = items.firstIndex(where: { $0 === item }) {
                let indexPath = IndexPath(row: index, section: index)
                if let collectionView = view as? UICollectionView {
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
}
