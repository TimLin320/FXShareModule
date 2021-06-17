//
//  snp+lyt.swift
//  AKExts
//
//  Created by edz on 2/23/21.
//

import AKMeta
import SnapKit

/// 布局扩展
public extension AKMeta where Meta: UIView {
    /// 扩展增加计算属性 以兼容snapkit布局
    var snp_top: ConstraintRelatableTarget {
        guard #available(iOS 11.0, *) else {
            return base.snp.top
        }
        return base.safeAreaLayoutGuide.snp.top
    }
    /// 扩展增加计算属性 以兼容snapkit布局
    var snp_bottom: ConstraintRelatableTarget {
        guard #available(iOS 11.0, *) else {
            return base.snp.bottom
        }
        return base.safeAreaLayoutGuide.snp.bottom
    }
}
