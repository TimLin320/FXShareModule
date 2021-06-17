//
//  FXShareHandler.swift
//  FXShare
//
//  Created by Lyman on 2021/5/14.
//

import UIKit

/// 分享句柄
public class FXShareHandler: NSObject {
    
    /// 图片压缩处理
    /// - Parameter imageList: 图片数组
    /// - Returns: 系统分享item
    class func sizeShareImgToSysList(imageList: [UIImage]) -> [FXShareSysItem] {
        var sysItemList: [FXShareSysItem] = []
        for (index, image) in imageList.enumerated() {
            var defautlCompriosn = 0.85
            var data = image.jpegData(compressionQuality: 0.85)
            if data == nil {
                data = image.pngData()
            }
            guard var dataWrap = data else {
                continue
            }
            
            while (dataWrap.count > 300 * 1024) {
                defautlCompriosn -= 0.05
                if let sizedImg = image.jpegData(compressionQuality: CGFloat(defautlCompriosn)) {
                    dataWrap = sizedImg
                } else {
                    break
                }
                if defautlCompriosn <= 0.5 { break }
            }
            
            let path = imgsLoadPath().appending("/shareImg\(index).jpg")
            let url = URL.init(fileURLWithPath: path)
            do {
                try dataWrap.write(to: url, options: .atomic)
            } catch {}
            let item = FXShareSysItem.init(image: image, locaUrl: url)
            sysItemList.append(item)
        }
        return sysItemList
    }
    
    /// 分享图片
    /// - Parameters:
    ///   - imageDataList: 图片数组
    ///   - compeletion: 完成回调
    class func share(imageList: [UIImage], compeletion: ((Bool)->Void)?) {
        let sysItemList = sizeShareImgToSysList(imageList: imageList)
        guard sysItemList.count > 0 else {
            return
        }
        let act = UIActivityViewController.init(activityItems: sysItemList, applicationActivities: nil)
        act.excludedActivityTypes = [.postToWeibo,
                                     .message,
                                     .mail,
                                     .print,
                                     .copyToPasteboard,
                                     .assignToContact,
                                     .saveToCameraRoll,
                                     .addToReadingList,
                                     .postToTencentWeibo,
                                     .airDrop]
        guard let top = topViewController() else {
            compeletion?(false)
            return
        }
        act.completionWithItemsHandler = { (type, res, list, error) in
            guard res == true else {
                compeletion?(false)
                return
            }
            compeletion?(true)
        }
        top.present(act, animated: true, completion: nil)
    }
    
    /// 分享图片Data
    /// - Parameters:
    ///   - imageDataList: 图片Data数组
    ///   - compeletion: 完成回调
    class func share(imageDataList: [Data], compeletion: ((Bool)->Void)?) {
        var sysItemList : [FXShareSysItem] = []
        
        for (index, imageData) in imageDataList.enumerated() {
            let path = FXShareHandler.imgsLoadPath().appending("/shareImage\(Date().timeIntervalSince1970 * 1000)\(index).jpg")
            let url = URL.init(fileURLWithPath: path)
            do {
                try imageData.write(to: url, options: .atomic)
            } catch {}
            let item = FXShareSysItem.init(imageData: imageData, locaUrl: url)
            sysItemList.append(item)
        }
        
        guard sysItemList.count > 0,
              let top = topViewController() else {
            compeletion?(false)
            return
        }
        
        let act = UIActivityViewController.init(activityItems: sysItemList, applicationActivities: nil)
        act.excludedActivityTypes = [.postToWeibo,
                                     .message,
                                     .mail,
                                     .print,
                                     .copyToPasteboard,
                                     .assignToContact,
                                     .saveToCameraRoll,
                                     .addToReadingList,
                                     .postToTencentWeibo,
                                     .airDrop]
        act.completionWithItemsHandler = { (type, res, list, error) in
            guard res == true else {
                compeletion?(false)
                return
            }
            compeletion?(true)
        }
        top.present(act, animated: true, completion: nil)
    }
    
    /// 支持唤起的渠道（微信、腾讯）
    /// - Returns: []
    class func allowTypes() -> [String] {
        return ["com.tencent.xin.sharetimeline", "com.tencent.mqq.ShareExtension"]
    }
    
    /// 图片路径
    /// - Returns:
    class func imgsLoadPath() -> String {
        return "\(NSHomeDirectory())/Documents"
    }
}
