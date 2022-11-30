//
//  CustomMiddleware.swift
//  ListKit_Example
//
//  Created by zhtg on 2022/11/27.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import TiledCellKit

/// 自定义中间件
class CustomMiddleware: TableViewMiddleware {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .blue
    }
}
