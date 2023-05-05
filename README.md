# TiledCellKit

TiledCellKit是一个TableView和CollectionView模型对cell辅助对应关系的iOS的Swift库
它的基本理念是一种cell对应一种Item，并且通过绑定关系绑定起来，tableView只需要操作item，即可对cell进行定制，达到cell类型和模型比较纯粹的关系

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

swift环境 ios10.0开始

## Installation

TiledCellKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TiledCellKit'
```
## 大概原理
Model绑定Cell，扁平画的思想，所见即Cell，有些圆角的也用Cell来实现，不使用Group Section，转而由Item来管理
比如，有些有些cell需要展开的需求，可以设计一个Item来管理其余Item

```swift
class SectionItem: NSObject, Item {
    var items: [RowItem]
    var showItems: Bool
}
```

tableView.delegate -> middleware -> Cell
                                      |
                                      |
viewModel/ViewController -> items -> item

## 使用

### 1.定制你的item和cell

```swift
import TiledCellKit

/// 模型
class TextItem: NSObject, Item {
    // Item必须实现的协议，指定cell类型，使Item和Cell绑定起来
    var viewClass: Cell.Type {
        ListTableViewCell.self
    }
    
    // model的属性
    var text: String?
}

/// cell
class ListTableViewCell: UITableViewCell, Cell {
    // 拿到item, 进行刷新刷新cell的方法
    func refresh(_ item: Item?) {
        if let item = item as? TextItem {
            textLabel?.text = item.text
        }
    }
}
```

### 管理你的Item数组，从网络或者其他地方获取到数组后，赋值给tableView.mid.items对象即可

```swift
var tableView = UITableView(frame: view.bounds, style: .plain)
view.addSubview(tableView)

/// 得到item数组，可以是网络请求的，或者是其他数组源得来的
var items = [TextItem]()

for i in 0..<10 {
    var item = TextItem()
    item.text = "Item\(i)"
    item.height = 88
    items.append(item)
}

// 赋值给tableView的mid对象的items数组属性
tableView.mid.items = items
```

### 其他

#### item高度可以通过以下两个方法来控制，

```swift
var height: Double? { get set }
func height(withViewWidth width: Double) -> Double
```

第一个是属性，直接赋值即可，如 item.height = 44.0 这样，第二种是返回的方式
collectionView的也是一样

#### 自定义tableView代理

```swift
/// 自定义中间件
class CustomMiddleware: TableViewMiddleware {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .blue
    }
}

// 赋值给tableView，替换默认的中间件
tableView.mid = CustomMiddleware()
    
// 赋值给tableView的mid对象的items数组属性
tableView.mid.items = items
```

#### 刷新cell
```swift
// 直接刷新的方式，这种方式相当于cell刷新item，对于tableView高度没有改变
let item = TextItem()
item.reload()
```

```swift
// 刷新TableView的IndexPath，如果高度有改变，则其也会改变
let item = TextItem()
tableView.reload(item: item)
```

#### 默认提供的cell
由于cell的差别比较大，只默认提供了空白的cell，用于显示空白
```swift
let space = SpaceTableViewItem()
space.height = 99
items.append(space)
```


## Author

zhtut zhtg@icloud.com

## License

TiledCellKit is available under the MIT license. See the LICENSE file for more info.
