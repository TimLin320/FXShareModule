//
//  obj+runtime.swift
//  AKExts
//
//  Created by edz on 3/2/21.
//

import AKMeta

/// token set
private var __onceTokens = [String]()

// MARK: - DispatchQueue 扩展
public extension AKMeta where Meta: DispatchQueue {
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.

     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    private static func once(_ token: String, excute: ()->Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        guard __onceTokens.contains(token) == false else {
            return
        }
        __onceTokens.append(token)
        excute()
    }

    /// once执行
    static func once(file: String = #file, function: String = #function, line: Int = #line, block:()->Void) {
        let token = file + ":" + function + ":" + String(line)
        once(token, excute: block)
    }
}

// MARK:-  Object扩展
public extension NSObject {
    /// 运行时初始化
    static func init4Runtime() {
        DispatchQueue.ak.once {
            guard let fromMethod = class_getInstanceMethod(self, #selector(setNilValueForKey(_:))) else {
                return
            }
            guard let toMethod = class_getInstanceMethod(self, #selector(setNilValueFor(_:))) else {
                return
            }
            method_exchangeImplementations(fromMethod, toMethod)
        }
    }
    /// 防止给基本数据类型映射nil时崩溃
    @objc func setNilValueFor(_ key: String) {}
}

// MARK: - NSObject扩展 - 转换
public extension AKMeta where Meta: NSObject {
    
}
