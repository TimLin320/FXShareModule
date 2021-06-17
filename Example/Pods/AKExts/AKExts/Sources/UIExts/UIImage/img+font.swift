//
//  img+font.swift
//  AKExts
//
//  Created by edz on 4/14/21.
//

import AKMeta

/// UIImage 字体扩展
public extension AKMeta where Meta: UIImage {
    
    /// iconfont -> image(此方法会有锯齿)
    /// - Parameters:
    ///   - font: 字体<枚举>
    ///   - size: 字体大小
    ///   - imgSize: 图片大小
    ///   - color: 图片颜色
    /// - Returns: iconfont image
    private func icon(_ font: AKIconFontable, font size: CGFloat, image imgSize: CGSize, tint color: UIColor = .black) -> UIImage?  {
        let drawText = font.asCode
        let font = UIFont.ak.icon_fit_font(size)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let rect = CGRect(x:0, y:0, width:imgSize.width, height:imgSize.height)
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .paragraphStyle: paragraphStyle, .foregroundColor: color]
        
        UIGraphicsBeginImageContextWithOptions(imgSize, false, UIScreen.main.scale)
        drawText.draw(in: rect, withAttributes: attrs)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //TODO: 可优化点->缓存
        return image
    }
    
    /// iconfont -> image(此方法会有锯齿)
    /// - Parameters:
    ///   - font: 字体<枚举>
    ///   - size: 字体大小
    ///   - imgSize: 图片大小
    ///   - color: 图片颜色
    /// - Returns: iconfont image
    static func icon(_ font: AKIconFontable, font size: CGFloat, image imgSize: CGSize, tint color: UIColor = .black) -> UIImage?  {
        let drawText = font.asCode
        let font = UIFont.init(name: "iconfont", size: size)
        let frm = CGRect(origin: .zero, size: imgSize)
        let lab = UILabel(frame: frm)
        lab.font = font
        lab.text = drawText
        lab.textColor = color
        lab.textAlignment = .center
        //TODO: 可优化点->缓存
        return lab.ak.capture()
    }
}
