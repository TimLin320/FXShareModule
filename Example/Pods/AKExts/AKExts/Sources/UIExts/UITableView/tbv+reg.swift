//
//  tbv+reg.swift
//  AKExts
//
//  Created by edz on 2020/11/3.
//

import AKMeta

// MARK: - UITableView 链式扩展
public extension AKMeta where Meta: UITableView {
    
    // MARK: - Cell register and reuse
    /// Register cell nib
    /// - Parameter aClass: class
    func registerCellNib<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        self.base.register(nib, forCellReuseIdentifier: name)
    }
    
    /// Register cell class
    /// - Parameter aClass: class
    func registerCellClass<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        self.base.register(aClass, forCellReuseIdentifier: name)
    }
    
    // 选择原因：1、 func dequeueReusableCell(withIdentifier: String, for: IndexPath) -> UITableViewCell 与 2、func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell?   选择2需要改成 T! 所以改为选1
    /// Reusable Cell
    /// - Parameters:
    ///   - aClass: class
    ///   - forIndexPath: indexpath
    /// - Returns: cell
    func dequeueReusableCell<T: UITableViewCell>(_ aClass: T.Type, for forIndexPath:IndexPath) -> T {
        let name = String(describing: aClass)
        guard let cell = self.base.dequeueReusableCell(withIdentifier: name, for: forIndexPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    // MARK: - HeaderFooter register and reuse
    
    /// Register headerFooter  nib
    /// - Parameter aClass: class
    func registerHeaderFooterNib<T: UIView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        self.base.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }
    
    
    /// Register headerFooter  class
    /// - Parameter aClass: class
    func registerHeaderFooterClass<T: UIView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        self.base.register(aClass, forHeaderFooterViewReuseIdentifier: name)
    }
    
    /// Reusable headerFooter
    /// - Parameter aClass: class
    /// - Returns: headerFooter
    func dequeueReusableHeaderFooter<T: UIView>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        guard let cell = self.base.dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
}
