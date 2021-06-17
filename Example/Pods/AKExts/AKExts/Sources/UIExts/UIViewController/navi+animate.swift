//
//  navi+animate.swift
//  AKExts
//
//  Created by edz on 3/29/21.
//

import AKMeta

/// 导航控制器扩展 - 模拟动画回调
public extension AKMeta where Meta: UINavigationController {
    
    /// 模拟push
    /// - Parameters:
    ///   - vc: 目标控制器
    ///   - animated: 是否动画
    ///   - completion: 回调
    func push(_ vc: UIViewController, with animated: Bool = true, and completion: (()->Void)? = nil) {
        base.pushViewController(vc, animated: animated)
        guard let closure = completion else {
            return
        }
        handleTransition(animated, with: closure)
    }
    
    /// 模拟pop
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 回调
    func pop(_ animated: Bool = true, with completion: (()->Void)? = nil) {
        base.popViewController(animated: animated)
        guard let closure = completion else {
            return
        }
        handleTransition(animated, with: closure)
    }
    
    /// 模拟pop2
    /// - Parameters:
    ///   - vc: 目标控制器
    ///   - animated: 是否动画
    ///   - completion: 回调
    func pop2(_ vc: UIViewController, with animated: Bool = true, with completion: (()->Void)? = nil) {
        base.popToViewController(vc, animated: animated)
        guard let closure = completion else {
            return
        }
        handleTransition(animated, with: closure)
    }
    
    /// 模拟pop2root
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 回调
    func pop2Root(_ animated: Bool = true, with completion: (()->Void)? = nil) {
        base.popToRootViewController(animated: animated)
        guard let closure = completion else {
            return
        }
        handleTransition(animated, with: closure)
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
