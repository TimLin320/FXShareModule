//
//  color+pro.swift
//  AKExts
//
//  Created by edz on 3/2/21.
//

import UIKit
import AKMeta

// MARK: - Color扩展
public extension AKMeta where Meta: UIColor {
    /// 0xRRGGBB eg.(0xF2F2F2)
    static func RGBA(_ rgb: UInt, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgb & 0x0000FF) / 255.0,
                       alpha: CGFloat(alpha))
    }
    /// random color
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    /// 颜色灰度化
    func grayscale() -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        if self.base.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: 0.3 * saturation, brightness: brightness / 2, alpha: alpha)
        }
        return self.base
    }
}

