//
//  AKExts.swift
//  AKExts
//
//  Created by edz on 2/20/21.
//

import AKMeta
import CoreGraphics

/// 渐变类型
public enum AKGradientType {
    case t2b    //  由上至下
    case l2r    //  由左至右
    case tl2br  //  左上至右下
    case tr2bl  //  右上至左下
}

/// UIImage 扩展元类
public extension AKMeta where Meta: UIImage {
    
    /// 取Bundle图片
    static func imged(_ name: String, class cls: AnyClass) -> UIImage? {
        let image = UIImage(named: name)
        if image == nil {
            return UIImage(named: name, in: Bundle(for: cls), compatibleWith: nil)
        }
        return image
    }
    
    /**
    生成一个纯色的UIImage
    - parameter color: 颜色
                size：图片大小
    */
    static func createImg(_ color: UIColor, with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect.init(origin: .zero, size: size))
        let resImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resImg
    }
    
    /**
     生成一个渐变 的UIImage
     - parameter colors: 渐变颜色数组
                 gradientType ：渐变样式
                 size：图片大小
     */
    static func createGradient(_ colors: [UIColor], with size: CGSize, and type: AKGradientType = .l2r) -> UIImage? {
        var cgColorArray : [CGColor] = []
        for color in colors {
            cgColorArray.append(color.cgColor)
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let colorSpace = colors.last?.cgColor.colorSpace
        let gradient = CGGradient.init(colorsSpace: colorSpace,
                                       colors: cgColorArray as CFArray,
                                       locations: nil)
        
        var start = CGPoint.init(x: 0, y: 0)
        var end = CGPoint.init()
        switch type {
        case .t2b:
            end = CGPoint.init(x: 0, y: size.height)
        case .l2r:
            end = CGPoint.init(x: size.width, y: 0)
        case .tl2br:
            end = CGPoint.init(x: size.width, y: size.height)
        case .tr2bl:
            start = CGPoint.init(x: size.width, y: 0)
            end = CGPoint.init(x: 0, y: size.height)
        }
        guard let gradWrap = gradient else {
            return nil
        }
        context?.drawLinearGradient(gradWrap, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        let resImg = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()
        return resImg
    }
    
    /**
     生成一个圆角 的UIImage
     - parameter color: 图片颜色
     - parameter size: 图片大小
     - parameter radius: 圆角弧度
     */
    static func createRoundCorner(_ color: UIColor, with size: CGSize, and radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let rect = CGRect.init(origin: .zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(rect)
        context?.setFillColor(color.cgColor)
        let bezi = UIBezierPath.init(roundedRect: rect, cornerRadius: radius)
        bezi.fill()
        let resImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resImg
    }
    
    /**
     图片TintColor更改
     */
    func resetTintColor(_ color : UIColor) -> UIImage {
        let sz = self.base.size
        UIGraphicsBeginImageContext(sz)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: sz.width, height: sz.height)
        UIRectFill(bounds)
        self.base.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    /**
     圆角化处理
     */
    func fillet(_ radius: CGFloat, with corners: UIRectCorner = .allCorners) -> UIImage? {
        let sz = base.size
        let bds = CGRect(origin: .zero, size: sz)
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(sz, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext() //关闭上下文
        }
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let path = UIBezierPath(roundedRect: bds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        ctx.addPath(path.cgPath)
        ctx.clip()  //裁剪
        self.base.draw(in: bds) //将原图片画到图形上下文
        ctx.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        return output
    }
    
    /**
     重置size
     */
    func scale2Size(_ size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        self.base.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    /**
     修正图片方向
     */
    func fixOrientation() ->  UIImage {
        if self.base.imageOrientation == .up {
            return self.base
        }
        let sz = self.base.size
        var transform = CGAffineTransform.identity
        switch self.base.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x:sz.width, y:sz.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x:sz.width, y:0)
            transform = transform.rotated(by: .pi/2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x:0, y:sz.height)
            transform = transform.rotated(by: -.pi/2)
        default:
            break
        }
        switch self.base.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x:sz.width, y:0)
            transform = transform.scaledBy(x:-1, y:1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x:sz.height, y:0);
            transform = transform.scaledBy(x:-1, y:1)
        default:
            break
        }
        let ctx = CGContext(data:nil, width:Int(sz.width), height:Int(sz.height), bitsPerComponent:self.base.cgImage!.bitsPerComponent, bytesPerRow:0, space:self.base.cgImage!.colorSpace!, bitmapInfo:self.base.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        switch self.base.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.base.cgImage!, in:CGRect(x:CGFloat(0), y:CGFloat(0), width:CGFloat(sz.height), height:CGFloat(sz.width)))
        default:
            ctx?.draw(self.base.cgImage!, in:CGRect(x:CGFloat(0), y:CGFloat(0), width:CGFloat(sz.width), height:CGFloat(sz.height)))
        }
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)

        return img
    }
    
    /// 压缩
    /// - Parameter maxLen: 最大不超过
    /// - Returns: 压缩后的图片
    func compress(_ maxLen: Int) -> UIImage {
        var compression: CGFloat = 1
        guard var data = base.jpegData(compressionQuality: compression),
            data.count > maxLen else {
            return base
        }
        // Compress by data count
        var max: CGFloat = 1
        var min: CGFloat = 0
        var img: UIImage = UIImage.init()
        let compressedData: Data = Data.init()
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = base.jpegData(compressionQuality: compression)!
            img = UIImage(data: data)!
            data = img.jpegData(compressionQuality: 1.0)!
            if CGFloat(compressedData.count) < CGFloat(max) * 0.9 {
                min = compression
            } else if compressedData.count > maxLen {
                max = compression
            } else {
                break
            }
        }
        var resultImage: UIImage = UIImage(data: data)!
        if data.count < maxLen { return resultImage }
        // Compress by image size
        var lastDataLength: Int = 0
        while data.count > maxLen, data.count != lastDataLength {
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(maxLen) / CGFloat(data.count)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                      height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = resultImage.jpegData(compressionQuality: compression)!
        }
        return resultImage
    }
}
