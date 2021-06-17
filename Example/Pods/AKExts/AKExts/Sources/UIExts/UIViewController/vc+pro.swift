//
//  vc+pro.swift
//  AKExts
//
//  Created by edz on 3/29/21.
//

import AKMeta

/// 外部参数关联属性
private struct ak_associatedKeys {
    static var acceptOpts = "ak_options_route"
}

/// VC扩展 - 属性
public extension AKMeta where Meta: UIViewController {
    
    /// 路由传参使用源参数
    var routeOpts: [String: Any]? {
        set {
            objc_setAssociatedObject(self.base, &ak_associatedKeys.acceptOpts, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let rs = objc_getAssociatedObject(self.base, &ak_associatedKeys.acceptOpts) as? [String: Any] {
                return rs
            }
            return nil
        }
    }
}
