//
//  FXAlbumHandler.swift
//  FXShare
//
//  Created by Lyman on 2020/12/8.
//

import UIKit
import Photos
import AKHud

public class FXAlbumHandler: NSObject {

    /// 保存图片到相册
    /// - Parameters:
    ///   - imgList: 图片数组
    ///   - showSuccessInfo: 是否展示保存成功提示
    ///   - finishClosure: 保存成功回调
    class func saveToAlbum(imgList: [UIImage],
                           showSuccessInfo: Bool = true,
                           finishClosure: ((_ succeed: Bool) -> Void)? = nil) {
        
        saveToAlbum(change: {
            for img in imgList {
                PHAssetChangeRequest.creationRequestForAsset(from: img)
            }
        }, showSuccessInfo: showSuccessInfo, finishClosure: finishClosure)
    }
    
    /// 保存图片到相册
    /// - Parameters:
    ///   - imgFileUrlList: 图片链接数组
    ///   - showSuccessInfo: 是否展示保存成功提示
    ///   - finishClosure: 保存成功回调
    class func saveToAlbum(imgFileUrlList: [URL],
                           showSuccessInfo: Bool = true,
                           finishClosure: ((_ succeed: Bool) -> Void)? = nil) {
        saveToAlbum(change: {
            for file in imgFileUrlList {
                if file.isFileURL == false { continue }
                PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: file)
            }
        }, showSuccessInfo: showSuccessInfo, finishClosure: finishClosure)
    }
    
    /// 保存视频到相册
    /// - Parameters:
    ///   - videoFileUrlList: 视频链接数组
    ///   - showSuccessInfo: 是否展示保存成功提示
    ///   - finishClosure: 保存成功回调
    class func saveVideosToAlbum(videoFileUrlList: [URL],
                                 showSuccessInfo: Bool = true,
                                 finishClosure: ((_ succeed: Bool) -> Void)? = nil) {
        saveToAlbum(change: {
            for file in videoFileUrlList {
                if file.isFileURL == false { continue }
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: file)
            }
        }, showSuccessInfo: showSuccessInfo, finishClosure: finishClosure)
    }
    
    /// 保存图片到相册
    /// - Parameters:
    ///   - change: 相册内容变更
    ///   - showSuccessInfo: 是否展示保存成功提示
    ///   - finishClosure: 保存成功回调
    class func saveToAlbum(change: @escaping ()->Void,
                           showSuccessInfo: Bool = true,
                           finishClosure: ((_ succeed: Bool) -> Void)? = nil) {
        let saveBlock: ()->Void = {
            PHPhotoLibrary
                .shared()
                .performChanges(change,
                                completionHandler: { (finish, error) in
                DispatchQueue.main.async {
                    if finish, error == nil, showSuccessInfo {
                        AKHud.showToast("成功保存到相册")
                    } else if showSuccessInfo {
                        guard let errorMsg = error?.localizedDescription, !errorMsg.isEmpty else {
                            return
                        }
                        AKHud.showToast(errorMsg)
                    }
                    finishClosure?((finish && error == nil))
                }
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        saveBlock()
                    }
                }
            }
        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
            saveBlock()
        } else {
            AKHud.showToast("请打开相册权限")
            finishClosure?(false)
        }
    }
    
    /// 获取相册权限状态
    /// - Parameter completionClosure: 是否授权回调
    class func authorizePhotoWith(completionClosure: @escaping (Bool)->Void) {
        let granted = PHPhotoLibrary.authorizationStatus()
        switch granted {
        case PHAuthorizationStatus.authorized:
            completionClosure(true)
        case PHAuthorizationStatus.denied, PHAuthorizationStatus.restricted:
            completionClosure(false)
        case PHAuthorizationStatus.notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                DispatchQueue.main.async {
                    completionClosure(status == PHAuthorizationStatus.authorized ? true : false)
                }
            })
        case PHAuthorizationStatus.limited:
            completionClosure(true)
        @unknown default:
            completionClosure(false)
        }
    }
}
