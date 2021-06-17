//
//  scrl+pro.swift
//  AKExts
//
//  Created by edz on 3/8/21.
//

import AKMeta

// MARK: - UIScrollView 扩展属性
public extension AKMeta where Meta: UIScrollView {
    
    /// 全局初始化
    func init4Runtime() {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
    }
    
    /// 是否正在滚动(此方法不包括手动设置contentOffset的情形)
    var isScrolling: Bool {
        return !base.isDragging && !base.isDecelerating && !base.isTracking
    }
    
    /// 滚到顶部<by->rect>
    /// - Parameter animated: 是否动画
    func scroll2TopByRect(_ animated: Bool = true) {
        let rect = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        base.scrollRectToVisible(rect, animated: animated)
    }
    
    /// 滚到顶部<by->offset>
    /// - Parameter animated: 是否动画
    func scroll2TopByOffset(_ animated: Bool = true) {
        base.setContentOffset(.zero, animated: animated)
    }
}
