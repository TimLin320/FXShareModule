//
//  clv+reg.swift
//  AKExts
//
//  Created by edz on 2020/11/3.
//

import AKMeta

// MARK: - UICollectionView 链式扩展
public extension AKMeta where Meta: UICollectionView {
    
    // MARK: - Cell register and reuse
    
    /// Register cell nib
    /// - Parameter aClass: class
    func registerCellNib<T: UICollectionViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        self.base.register(nib, forCellWithReuseIdentifier: name)
    }
    
    /// Register cell class
    /// - Parameter aClass: class
    func registerCellClass<T: UICollectionViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        self.base.register(aClass, forCellWithReuseIdentifier: name)
    }
    
    /// reusableCell
    /// - Parameters:
    ///   - aClass: aclass
    ///   - forIndexPath: indexpath
    /// - Returns: cell
    func dequeueReusableCell<T: UICollectionViewCell>(_ aClass: T.Type, for forIndexPath: IndexPath) -> T {
        let name = String(describing: aClass)
        guard let cell = self.base.dequeueReusableCell(withReuseIdentifier: name, for: forIndexPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    // MARK: - HeaderFooter register and reuse
    
    /// Register headerFooter nib
    /// - Parameter aClass: class
    func registerHeaderFooterNib<T: UICollectionReusableView>(_ aClass: T.Type, forSupplementaryViewOfKind kind: String) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        self.base.register(nib, forSupplementaryViewOfKind:kind , withReuseIdentifier: name)
    }
    
    /// Register headerFooter class
    /// - Parameter aClass: class
    func registerHeaderFooterClass<T: UICollectionReusableView>(_ aClass: T.Type, forSupplementaryViewOfKind kind: String) {
        let name = String(describing: aClass)
        self.base.register(aClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: name)
    }
    
    /// reusableHeaderFooter
    /// - Parameters:
    ///   - aClass: aclass
    ///   - kind: kind
    ///   - forIndexPath: indexpath
    /// - Returns: HeaderFooter
    func dequeueReusableHeaderFooter<T: UICollectionReusableView>(_ aClass: T.Type, kind: String, for forIndexPath: IndexPath) -> T {
        let name = String(describing: aClass)
        guard let cell = self.base.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: name, for: forIndexPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
}
