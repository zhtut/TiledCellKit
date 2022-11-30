//
//  ViewController.swift
//  TiledCellKit
//
//  Created by zhtut on 11/30/2022.
//  Copyright (c) 2022 zhtut. All rights reserved.
//

import UIKit
import TiledCellKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        /// 得到item数组，可以是网络请求的，或者是其他数组源得来的
        var items = [Item]()
        
        let space = TableViewSpaceItem()
        space.height = 99
        items.append(space)
        
        for i in 0..<10 {
            let item = TextItem()
            item.text = "Item\(i)"
            item.height = 88
            items.append(item)
        }
        
        tableView.mid = CustomMiddleware()
        
        // 赋值给tableView的mid对象的items数组属性
        tableView.mid.items = items
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            for item in items {
                if let item = item as? TextItem {
                    item.text = "after++\(item.text ?? "")"
                    item.reload()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

