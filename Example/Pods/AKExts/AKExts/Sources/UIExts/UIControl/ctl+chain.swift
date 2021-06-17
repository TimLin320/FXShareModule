//
//  ctl+chain.swift
//  AKExts
//
//  Created by edz on 4/1/21.
//

import UIKit

// MARK: - UIControl 链式扩展
public extension UIControl {
    
    /// 添加事件
    /// - Parameters:
    ///   - sel: 方法
    ///   - target: 目标
    /// - Returns: 控件自身
    @discardableResult
    func action(_ sel: Selector, for target: Any) -> Self {
        self.addTarget(target, action: sel, for: .touchUpInside)
        return self
    }
    
    /// 内容水平对齐
    /// - Parameter align: 对齐方式
    /// - Returns: 控件自身
    @discardableResult
    func cntHAlign(_ align: UIControl.ContentHorizontalAlignment) -> Self {
        self.contentHorizontalAlignment = align
        return self
    }
    
    /// 内容垂直对齐
    /// - Parameter align: 对齐方式
    /// - Returns: 控件自身
    @discardableResult
    func cntVAlign(_ align: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = align
        return self
    }
}
