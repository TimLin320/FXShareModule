//
//  imgvue+func.swift
//  AKExts
//
//  Created by edz on 3/24/21.
//

import UIKit

/// UIImageView扩展
public extension UIImageView {
    
    /// 设置图片
    /// - Parameter img: 图片
    /// - Returns: 自身(for chainable)
    @discardableResult
    func img(_ img: UIImage?) -> Self {
        image = img
        return self
    }
}
