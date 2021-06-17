//
//  AKHud.swift
//  AKHud
//
//  Created by edz on 3/17/21.
//

import UIKit

/// hud for ak-components
public class AKHud {
    
    /// 展示菊花hud
    public static func showHud() {
        HUD.show(.systemActivity)
    }
    
    /// 展示菊花hud
    public static func showHud(_ on: UIView) {
        HUD.show(.systemActivity, onView: on)
    }
    
    /// 隐藏菊花hud
    public static func hideHud() {
        HUD.hide()
    }
    
    /// 展示居中Toast(默认2秒)
    public static func showToast(_ info: String, duration: Int = 2) {
        SwiftNotice.clear()
        SwiftNotice.showText(info, autoClear: true, autoClearTime: duration)
    }
}
