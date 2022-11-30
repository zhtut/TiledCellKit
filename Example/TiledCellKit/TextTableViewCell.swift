//
//  ListTableViewCell.swift
//  ModelTableView_Example
//
//  Created by zhtg on 2022/10/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import TiledCellKit

/// cell
class TextTableViewCell: UITableViewCell, Cell {
    // 拿到item, 进行刷新刷新cell的方法
    func refresh(_ item: Item?) {
        if let item = item as? TextItem {
            textLabel?.text = item.text
        }
    }
}
