//
//  int+fit.swift
//  AKExts
//
//  Created by edz on 3/2/21.
//

import AKMeta
import SwiftyFitsize

// MARK: - 高度/宽度 自适应
extension Int: AKMetaProtocol {}
public extension AKMeta where Meta == Int {
    /// 对比高度适配(安全区域)
    func fit_by_height(_ safe: Bool = true) -> CGFloat {
        guard safe else {
            return CGFloat(base)≈
        }
        return CGFloat(base)∥=
    }
    /// 对比宽度适配
    func fit_by_width() -> CGFloat {
        return (base)≈
    }
    /// 随机数(默认0～100)
    static func random(_ mix: Int = 0, to max: Int = 100) -> Int {
        return mix + (Int(arc4random()) % (max - mix))
    }
}
