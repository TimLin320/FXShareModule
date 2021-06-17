//
//  btn+lyt.swift
//  AKExts
//
//  Created by edz on 2/23/21.
//

import UIKit

/// button图片位置
public enum AKBtnImgStyle {
    case top    // 图片在上
    case left   // 图片在左
    case right  // 图片在右
    case bottom // 图片在下
}

// MARK: - UIButton扩展 - 布局
public extension UIButton {
    /**
     重新布局图片位置
     - Parameter style: 默认图片在上
     - Parameter margin: 默认5
     */
    @discardableResult
    func adjustImgZone(_ style: AKBtnImgStyle = .top, margin space: CGFloat = 5) -> Self {
        /*
         * tip：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
         *  如果只有title，那它上下左右都是相对于button的，image也是一样；
         *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
         */
        //获取image宽高
        let imageW = self.imageView?.frame.size.width
        let imageH = self.imageView?.frame.size.height
        //获取label宽高
        var lableW = self.titleLabel?.intrinsicContentSize.width
        let lableH = self.titleLabel?.intrinsicContentSize.height
        
        var imageEdgeInsets:UIEdgeInsets = .zero
        var lableEdgeInsets:UIEdgeInsets = .zero
        if self.frame.size.width <= lableW! { //如果按钮文字超出按钮大小，文字宽为按钮大小
            lableW = self.frame.size.width
        }
        //根据传入的 style 及 space 确定 imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: 0.0 - lableH! - space*0.5, left: 0, bottom: 0, right: 0.0 - lableW!)
            lableEdgeInsets = UIEdgeInsets(top: 0, left: 0.0 - imageW!, bottom: 0.0 - imageH! - space*0.5, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0.0 - space*0.5, bottom: 0, right: space*0.5)
            lableEdgeInsets = UIEdgeInsets(top: 0, left: space*0.5, bottom: 0, right: 0.0 - space*0.5)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0.0 - lableH! - space*0.5, right: 0.0 - lableW!)
            lableEdgeInsets = UIEdgeInsets(top: 0.0 - imageH! - space*0.5, left: 0.0 - imageW!, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: lableW! + space*0.5, bottom: 0, right: 0.0 - lableW! - space*0.5)
            lableEdgeInsets = UIEdgeInsets(top: 0, left: 0.0 - imageW! - space*0.5, bottom: 0, right: imageW! + space*0.5)
        }
        //赋值
        self.titleEdgeInsets = lableEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        self.layoutIfNeeded()
        return self
    }
}
