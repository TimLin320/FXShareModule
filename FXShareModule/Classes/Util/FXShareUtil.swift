//
//  FXShareUtil.swift
//  FXShare
//
//  Created by Lyman on 2021/5/17.
//

import UIKit

extension NSObject {
    
    /// 获取当前第一相应控制器
    /// - Parameter base: 根控制器（默认应用rootViewController）
    /// - Returns:
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            if nav.visibleViewController is UIAlertController {
                return topViewController(nav.topViewController)
            }
            return topViewController(nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            guard let selected = tab.selectedViewController else { return base }
            return topViewController(selected)
        }
        
        if let presented = base?.presentedViewController {
            if presented is UIAlertController {
                return base
            }
            return topViewController(presented)
        }
        
        return base
    }
}

extension UIImage {
    
    /// 压缩图片
    /// - Parameters:
    ///   - image: 原图片
    ///   - maxLength: 最大大小
    /// - Returns: 压缩后图片
    class func compressImage(_ image: UIImage, toByte maxLength: Int) -> UIImage {
        var compression: CGFloat = 1.0
        
        guard var data = image.jpegData(compressionQuality: compression),
            data.count > maxLength else { return image }
        
        // Compress by data count
        var max: CGFloat = 1
        var min: CGFloat = 0
        var img: UIImage = UIImage.init()
        var compressedData: Data = Data.init()
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = image.jpegData(compressionQuality: compression)!
            img = UIImage(data: data)!
            compressedData = img.jpegData(compressionQuality: 1.0)!
            if CGFloat(compressedData.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if compressedData.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        
        var resultImage: UIImage = UIImage(data: data)!
        if compressedData.count < maxLength { return resultImage }
        
        // Compress by image size
        var lastDataLength: Int = 0
        while compressedData.count > maxLength, compressedData.count != lastDataLength {
            lastDataLength = compressedData.count
            let ratio: CGFloat = CGFloat(maxLength) / CGFloat(compressedData.count)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                      height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            compressedData = resultImage.jpegData(compressionQuality: compression)!
        }
        
        return resultImage
    }
    
    /// 压缩图片
    /// - Parameters:
    ///   - image: 原图片
    ///   - maxLength: 最大大小
    ///   - defaultCompression: 默认压缩比例（默认为1.0）
    /// - Returns: 压缩后图片Data
    class func compressImageData(_ image: UIImage, toByte maxLength: Int, defaultCompression: CGFloat = 1.0) -> Data {
        var compression: CGFloat = defaultCompression
        guard var data = image.jpegData(compressionQuality: compression),
              data.count > maxLength else { return image.jpegData(compressionQuality: compression)! }
        
        var max: CGFloat = 1
        var min: CGFloat = 0
        let compressedData: Data = Data.init()
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = image.jpegData(compressionQuality: compression)!
            if CGFloat(compressedData.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if compressedData.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        
        var resultImage: UIImage = UIImage(data: data)!
        if data.count < maxLength { return data }
        
        // Compress by image size
        var lastDataLength: Int = 0
        while data.count > maxLength, data.count != lastDataLength {
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(maxLength) / CGFloat(data.count)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                      height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = resultImage.jpegData(compressionQuality: compression)!
        }
        
        return data
    }
}
