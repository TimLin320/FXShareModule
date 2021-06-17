//
//  vue+pro.swift
//  AKExts
//
//  Created by edz on 2/23/21.
//

import AKMeta

// MARK: - UIView扩展 - 属性化
public extension AKMeta where Meta: UIView {
    /**
     父视图所属控制器
     */
    func superVC() -> UIViewController? {
        var nextView : UIResponder = self.base
        while nextView.next != nil {
            if nextView.next!.isKind(of: UIViewController.self) == true{
                return nextView.next as? UIViewController
            } else {
                nextView = nextView.next!
            }
        }
        return nil
    }
}
