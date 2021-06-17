//
//  tab+animate.swift
//  AKExts
//
//  Created by edz on 3/29/21.
//

import AKMeta

/// Tab控制器扩展 - 模拟动画回调
public extension AKMeta where Meta: UITabBarController {
    
    /// 切换tab
    /// - Parameters:
    ///   - index: 索引
    ///   - completion: 回调
    func select(_ index: Int, and completion: (()->Void)? = nil) {
        guard base.selectedIndex != index else {
            completion?()
            return
        }
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.30)
        CATransaction.setCompletionBlock(completion)
        base.selectedIndex = index
        CATransaction.commit()
        
//        guard let closure = completion else {
//            return
//        }
//        handleTransition(true, with: closure)
    }
    
    /// 统一处理转场动画回调
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 回调
    private func handleTransition(_ animated: Bool = true, with completion:@escaping ()->Void) {
        if animated, let coordinator = base.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { (ctx) in
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
