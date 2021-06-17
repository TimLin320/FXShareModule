//
//  dict+pro.swift
//  AKExts
//
//  Created by edz on 3/2/21.
//

import AKMeta

// MARK: - 结构体直接扩展
public extension Dictionary where Key == String, Value == Any {
    /// 插入键值对
    /// - Parameters:
    ///   - key: 键
    ///   - value: 值
    mutating func insert(_ key: String, value: Any?) {
        guard let v = value else {
            return
        }
        self[key] = v
    }
}

// MARK: - Dict 扩展
extension Dictionary: AKMetaProtocol {}
public extension AKMeta where Meta  == Dictionary<String, Any> {
    /// 内部联合
    func join(_ map: [String: Any]) -> [String: Any] {
        let tmp = NSMutableDictionary(dictionary: self.base)
        tmp.addEntries(from: map)
        return tmp as! Dictionary<String, Any>
    }
}
