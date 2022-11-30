//
//  ListItem.swift
//  ModelTableView_Example
//
//  Created by zhtg on 2022/10/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import TiledCellKit

/// 模型
class TextItem: NSObject, Item {
    // Item必须实现的协议，指定cell类型，使Item和Cell绑定起来
    var cellClass: Cell.Type {
        TextTableViewCell.self
    }
    
    // model的属性
    var text: String?
}
