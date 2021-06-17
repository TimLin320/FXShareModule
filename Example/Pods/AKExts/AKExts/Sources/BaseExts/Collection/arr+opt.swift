//
//  arr+opt.swift
//  AKExts
//
//  Created by edz on 4/8/21.
//

import AKMeta

// MARK: - Array 扩展
public extension Array where Element: Hashable {
    
    /// 去重并保持索引顺序
    var unique: [Element] {
        var uni = Set<Element>()
        uni.reserveCapacity(count)
        return filter { (e) -> Bool in
            return uni.insert(e).inserted
        }
    }
}

// MARK: - Array 命名空间扩展
extension Array: AKMetaProtocol {}
public extension AKMeta where Meta == Array<Any> {}
