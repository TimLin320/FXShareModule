//
//  clt+get.swift
//  AKExts
//
//  Created by edz on 4/8/21.
//

import AKMeta

/// 安全取值
public extension Collection {
    /// 安全取值 无默认值
    subscript (get index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    /// 安全取值 提供默认值
    subscript (get index: Index, default e: Element) -> Element {
        return indices.contains(index) ? self[index] : e
    }
}

// MARK: - 命名空间内扩展
public extension AKMeta where Meta: Collection {
    /// 转换为json-string
    func toJsonString() -> String? {
        if JSONSerialization.isValidJSONObject(base) {
            do {
                let data = try JSONSerialization.data(withJSONObject: base, options: JSONSerialization.WritingOptions.init(rawValue: 0))
                let res = String.init(data: data, encoding: .utf8)
                return res
                
            } catch {
                
            }
        }
        return nil
    }
}
