//
//  vue+chan.swift
//  AKExts
//
//  Created by edz on 3/22/21.
//

import UIKit
import SnapKit

/// view 链式调用协议
public protocol AKVueChainable {}

/// vue链式协议默认实现
public extension AKVueChainable where Self: UIView {
    
    /// 配置vue
    /// - Parameter config: 配置块
    /// - Returns: 自身(for chainable)
    @discardableResult
    func cfg(_ config: (Self)->Void) -> Self {
        config(self)
        return self
    }
}

/// 链式调用(不放在命名空间里/省去冗余麻烦)
extension UIView: AKVueChainable {
    
    /// 添加到UI层级
    /// - Parameter sp: 父view
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func add2(_ sp: UIView) -> Self {
        sp.addSubview(self)
        return self
    }
    
    /// 是否加入响应链
    /// - Parameter enable: 是否加入
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func respondable(_ enable: Bool) -> Self {
        self.isUserInteractionEnabled = enable
        return self
    }
    
    /// 设置frame
    /// - Parameter frm: 相对位置
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func frame(_ frm: CGRect) -> Self {
        self.frame = frm
        return self
    }
    
    /// 设置bounds
    /// - Parameter bds: 绝对位置
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func bounds(_ bds: CGRect) -> Self {
        self.bounds = bds
        return self
    }
    
    /// 背景色
    /// - Parameter color: 颜色
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func bgColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    /// 设置边界裁剪
    /// - Parameter clip: 是否裁剪
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func clipBounds(_ clip: Bool) -> Self {
        self.layer.masksToBounds = clip
        return self
    }
    
    /// 边框色
    /// - Parameter color: 颜色
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func borderColor(_ color: UIColor) -> Self {
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
        return self
    }
    
    /// 边框宽
    /// - Parameter width: 宽度
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func borderWidth(_ width: CGFloat) -> Self {
        self.layer.borderWidth = width
        return self
    }
    
    /// 圆角弧度
    /// - Parameter radii: 弧度
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func cornerRadius(_ radii: CGFloat) -> Self {
        self.layer.cornerRadius = radii
        self.layer.masksToBounds = true
        return self
    }
    
    /// 内容模式
    /// - Parameter mode: 模式
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func cntMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    /**
     小屏幕隐藏(默认 iPhone5S)
     - Parameter screen: 参考屏幕
     - Returns: 自身(for chainable)
     */
    @discardableResult
    public func hiddenOnNarrow(_ screen: CGFloat = 320.0) -> Self {
        self.isHidden = UIScreen.main.bounds.width <= screen
        return self
    }
    
    /// snapkit布局
    /// - Parameter maker: 布局描述
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func lyt(_ maker: (ConstraintMaker)->Void) -> Self {
        self.snp.makeConstraints(maker)
        return self
    }
    
    /// 圆角化处理
    /// - Parameters:
    ///   - radius: 弧度
    ///   - corners: 四角集合
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func fillet(_ radius: CGFloat, with corners: UIRectCorner = .allCorners) -> Self {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return self
    }
    
    /// 添加渐变背景
    /// - Parameters:
    ///   - colors: 颜色集合
    ///   - locations: 渐变位置
    /// - Returns: 自身(for chainable)
    @discardableResult
    public func mkGradientBg(_ colors: [UIColor], at locations:[NSNumber]) -> Self{
        guard colors.count > 1, colors.count == locations.count else {
            return self
        }
        let cols = colors.map { (c) -> CGColor in
            return c.cgColor
        }
        let gly = CAGradientLayer()
        gly.frame = self.bounds
        gly.colors = cols
        gly.locations = locations
        self.layer.insertSublayer(gly, at: 0)
        return self
    }
    
    /// 不可压缩的方向(默认水平方向)
    /// - Parameter on: 方向
    /// - Returns: 自身(for chainable)
    public func mkIncompressible(_ on: NSLayoutConstraint.Axis = .horizontal) -> Self {
        self.setContentHuggingPriority(UILayoutPriority.required, for: on)
        self.setContentCompressionResistancePriority(UILayoutPriority.required, for: on)
        return self
    }
}
