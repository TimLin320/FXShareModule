//
//  Meta.swift
//  AKComponents
//
//  Created by edz on 6/10/20.
//  Copyright © 2020 edz. All rights reserved.
//

import UIKit
import Foundation

/// 定制自己的命名空间 类似OC的分类 ****---------------自定义命名空间实现

public struct AKMeta<Meta> {
    public var base: Meta
    public init(_ base: Meta) {
        self.base = base
    }
}

/// POP 协议
public protocol AKMetaProtocol {
    associatedtype NameType
    static var `ak`: AKMeta<NameType>.Type { get set }
    var `ak`: AKMeta<NameType> { get set}
}

/// POP默认实现
extension AKMetaProtocol {
    public static var `ak`: AKMeta<Self>.Type {
        get {
            return AKMeta<Self>.self
        }
        set {}
    }
    public var `ak`: AKMeta<Self> {
        get {
            return AKMeta(self)
        }
        set {}
    }
}

/// POP 默认添加到NSObject对象
extension NSObject: AKMetaProtocol {}
