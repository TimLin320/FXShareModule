//
//  date+fmt.swift
//  AKExts
//
//  Created by edz on 5/20/21.
//

import AKMeta

/// Date 扩展
extension Date: AKMetaProtocol {}
public extension AKMeta where Meta == Date {
    /// 时间戳(单位/秒)
    static func timestamp() -> String {
        return "\(Date().timeIntervalSince1970 * 1000)"
    }
}

