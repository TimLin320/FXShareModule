//
//  FXShareAccess.swift
//  FXShare
//
//  Created by Lyman on 2021/3/8.
//

import UIKit

/// 分享权限类型
public enum FXShareAccessType {
    case none                                               // 无限制
    case loginRequired                                      // 需要登录
    case platformRelationIDRequired(platform: String?)      // 需要绑定平台渠道id（需要登录）
}
