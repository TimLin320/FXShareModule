//
//  vue+img.swift
//  AKExts
//
//  Created by edz on 2/22/21.
//

import AKMeta

// MARK: - UIView扩展 - 图片化
public extension AKMeta where Meta: UIView {
    
    /// 自身截图
    func capture() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: base.bounds)
            return renderer.image { rendererContext in
                base.layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(base.bounds.size, false, UIScreen.main.scale)
            base.layer.render(in:UIGraphicsGetCurrentContext()!)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img
        }
    }
}
