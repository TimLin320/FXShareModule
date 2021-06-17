//
//  font+fit.swift
//  AKExts
//
//  Created by edz on 3/2/21.
//

import AKMeta
import SwiftyFitsize

// MARK: - UIFont 扩展
public extension AKMeta where Meta: UIFont {
    
    /// 非自适应固定  通过字体名字设置字体大小
    /// - Parameters:
    ///   - size: 字体大小
    ///   - name: 字体名称 默认PingFangSC-Regular
    ///   - bold: 如果没有对应字体的时候，用boldSystemFont还是systemFont 默认false
    /// - Returns: 字体UIFont
    private static func fix_name(size: CGFloat, name:String = "PingFangSC-Regular", bold: Bool = false) -> UIFont {
        return UIFont.init(name: name, size: size) ?? (bold ? UIFont.boldSystemFont(ofSize: size): UIFont.systemFont(ofSize: size))
    }
    
    /// 自适应   通过字体名字设置字体大小
    /// - Parameters:
    ///   - size: 字体大小
    ///   - name: 字体名称 默认PingFangSC-Regular
    ///   - bold: 如果没有对应字体的时候，用boldSystemFont还是systemFont 默认false
    ///   - ipad: 是不是ipad平台 true/false 默认false
    /// - Returns: 字体UIFont
    private static func fit_name(size: CGFloat, name:String = "PingFangSC-Regular", bold: Bool = false, ipad: Bool = false) -> UIFont {
        let font = fix_name(size: size, name: name, bold: bold)
        guard ipad else {
            return font≈
        }
        return font~
    }

    /// 非自适应固定 PingFangSC-Regular 字体
    /// - Parameter size: 字体大小
    /// - Returns: UIFont
    static func fix_pf_regular(_ size: CGFloat) -> UIFont {
        return fix_name(size: size)
    }
    
    /// 非自适应固定 PingFangSC-Medium 字体
    /// - Parameter size: 字体大小
    /// - Returns: UIFont
    static func fix_pf_medium(_ size: CGFloat) -> UIFont {
        return fix_name(size: size, name: "PingFangSC-Medium")
    }
    
    /// 非自适应固定 PingFangSC-Semibold 字体
    /// - Parameter size: 字体大小
    /// - Returns: UIFont
    static func fix_pf_semibold(_ size: CGFloat) -> UIFont {
        return fix_name(size: size, name: "PingFangSC-Semibold", bold: true)
    }
    
    /// 非自适应固定 helvetica 字体
    /// - Parameter size: 字体大小
    /// - Returns: UIFont
    static func fix_helve(_ size: CGFloat) -> UIFont {
        return fix_name(size: size, name: "Helvetica")
    }
    
    /// 苹方自适应字体regular
    /// - Parameters:
    ///   - size: 字体大小
    ///   - ipad: 是不是ipad平台 true/false 默认false
    /// - Returns: UIFont
    static func fit_pf_regular(_ size: CGFloat, ipad: Bool = false) -> UIFont {
        return fit_name(size: size, ipad: ipad)
    }

    /// 苹方自适应字体medium
    /// - Parameters:
    ///   - size: 字体大小
    ///   - ipad: 是不是ipad平台 true/false 默认false
    /// - Returns: UIFont
    static func fit_pf_medium(_ size: CGFloat, ipad: Bool = false) -> UIFont {
        return fit_name(size: size, name: "PingFangSC-Medium", ipad: ipad)
    }

    /// 苹方自适应字体semibold
    /// - Parameters:
    ///   - size: 字体大小
    ///   - ipad: 是不是ipad平台 true/false 默认false
    /// - Returns: UIFont
    static func fit_pf_semibold(_ size: CGFloat, ipad: Bool = false) -> UIFont {
        return fit_name(size: size, name: "PingFangSC-Semibold", bold: true, ipad: ipad)
    }
    
    /// 自适应 helvetica 字体
    /// - Parameter size: 字体大小
    /// - Returns: UIFont
    static func fit_helve(_ size: CGFloat, ipad: Bool = false) -> UIFont {
        return fit_name(size: size, name: "Helvetica", ipad: ipad)
    }
    
    /// iconfont自适应字体
    /// - Parameters:
    ///   - size: 字体大小
    ///   - ipad: 是不是ipad平台 true/false 默认false
    /// - Returns: UIFont
    static func icon_fit_font(_ size: CGFloat, ipad: Bool = false) -> UIFont {
        return fit_name(size: size, name: "iconfont", bold: false, ipad: ipad)
    }
}
