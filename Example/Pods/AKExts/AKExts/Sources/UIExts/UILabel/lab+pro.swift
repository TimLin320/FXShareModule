//
//  lab+pro.swift
//  AKExts
//
//  Created by edz on 3/31/21.
//

import AKMeta

/// UILabel扩展
public extension AKMeta where Meta: UILabel {
    
    /// 定制化label
    /// - Parameters:
    ///   - title: 标题
    ///   - size: 字体大小<自适应>
    ///   - color: 字体颜色
    /// - Returns: label
    static func custom(_ title: String, font: UIFont, text color: UIColor) -> Meta {
        let s = Meta(frame: .zero)
        s.font = font
        s.textColor = color
        s.text = title
        return s
    }
}
