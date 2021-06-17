//
//  str+convert.swift
//  AKExts
//
//  Created by edz on 2/20/21.
//

import AKMeta

/// 二维码容错率
public enum AKQRCorrectionLevel: String, CaseIterable {
    case L = "L"    //  7%
    case M = "M"    //  15%
    case Q = "Q"    //  25%
    case H = "H"    //  30%
}

// MARK: - 字符串扩展 - 转换/处理
public extension AKMeta where Meta == String {
    
    /// 生成QRCode二维码(默认15%容错率)
    func qrCodeImg(_ size: CGSize = CGSize(width: 200, height: 200), with level: AKQRCorrectionLevel = .M) -> UIImage? {
        guard let data = base.data(using:.utf8) else {
            return nil
        }
        var pms: [String: Any] = [:]
        pms["inputMessage"] = data
        pms["inputCorrectionLevel"] = level.rawValue
        guard let filter = CIFilter(name: "CIQRCodeGenerator", parameters: pms),
              let img = filter.outputImage else {
            return nil
        }
        let extSize = img.extent.size
        let scaleX = size.width / extSize.width
        let scaleY = size.height / extSize.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let output = img.transformed(by: transform)
        if let output = filter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
        }
        return UIImage(ciImage: output)
    }
    
    /// 转换Base64-->Image
    /// - Returns: 图片
    func decodeBase64Img() -> UIImage? {
        if let imgData = Data.init(base64Encoded: base, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) {
            return UIImage.init(data: imgData)
        }
        return nil
    }
    
    /// url编码
    /// - Returns: 编码后string
    func urlEncoded() -> String? {
        return base.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// url解码
    /// - Returns: 解码后string
    func urlDecoded() -> String? {
        return base.removingPercentEncoding
    }
    
    /// 转为远程url
    /// - Returns: 可选url
    func toURL() -> URL? {
        return URL(string: base)
    }
    
    /// 转为文件url
    /// - Returns: 可选url
    func toFileURL() -> URL {
        return URL(fileURLWithPath: base)
    }
    
    /// 转为json-obj
    /// - Returns: Any可选类型
    func toJsonObject() -> Any? {
        guard let jsonData = base.data(using: .utf8) else {
            return nil
        }
        do {
            return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        } catch {
            debugPrint("转换json-obj失败:\(error.localizedDescription)")
        }
        return nil
    }
}
