//
//  img+qr.swift
//  AKExts
//
//  Created by edz on 3/18/21.
//

import AKMeta

// MARK: - UIImage扩展 读取二维码信息
public extension AKMeta where Meta: UIImage {
    
    /// 读取二维码图片信息
    func readQRCode() -> [String]? {
        guard let ciImage = base.ciImage else {
            return nil
        }
        let context = CIContext()
        var options: [String: Any] = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let qrDetector = CIDetector(
            ofType: CIDetectorTypeQRCode,
            context: context,
            options: options
        )
        // 调整方向
        if ciImage.properties.keys
            .contains((kCGImagePropertyOrientation as String)) {
            options = [
                CIDetectorImageOrientation: ciImage
                    .properties[(kCGImagePropertyOrientation as String)] as Any
            ]
        } else {
            options = [CIDetectorImageOrientation: 1]
        }
        // 识别
        guard let features = qrDetector?.features(in: ciImage, options: options) else {
            return nil
        }
        // 转换类型
        return features.compactMap { ($0 as? CIQRCodeFeature)?.messageString }
    }
}
