//
//  FXShareTypeSelection.swift
//  FXShare
//
//  Created by Lyman on 2021/3/10.
//
//  分享方式选择弹框协议
//

import UIKit

public protocol FXShareTypeSelection: class {
    
    /// 方式列表
    var types: [FXShareType] {get set}
    
    /// 选择完方式后的回调
    var selectClosure: ((FXShareType) -> Void) {get set}
    
    /// 取消回调
    var cancelClosure: (() -> Void) {get set}
}
