//
//  FXShare.swift
//  FXShare
//
//  Created by Lyman on 2020/11/19.
//

import UIKit
import AKHud

/// 分享方式
public enum FXShareType: Int {
    
    case friend = 1             // 分享到微信朋友
    case circle                 // 分享到微信朋友圈
    case qq                     // 分享到QQ会话
    case qqZone                 // 分享到QQ空间
    case album                  // 保存到系统相册
    case inviteLink             // 复制邀请链接
    case sharePoster            // 分享海报
    case openRedPacket          // 拆红包
    case okGroup                // 一键发群
    case okTimeline             // 一键发圈
    
    var imageName: String {
        switch self {
        case .friend, .okGroup:
            return "share_friend_image"
        case .circle, .okTimeline:
            return "share_circle_image"
        case .qq:
            return "share_qq_image"
        case .qqZone:
            return "share_qqZone_image"
        case .album:
            return "share_album_image"
        case .inviteLink:
            return "share_inviteLink_image"
        case .sharePoster:
            return "share_post_image"
        case .openRedPacket:
            return "share_redPacket_image"
        }
    }
    
    var title: String {
        switch self {
        case .friend:
            return "微信"
        case .circle:
            return "朋友圈"
        case .qq:
            return "QQ"
        case .qqZone:
            return "QQ空间"
        case .album:
            return "保存图片"
        case .inviteLink:
            return "邀请链接"
        case .sharePoster:
            return "分享海报"
        case .openRedPacket:
            return "拉新口令红包"
        case .okGroup:
            return "一键发群"
        case .okTimeline:
            return "一键发圈"
        }
    }
}

///
public enum FXShareResult {
    /// 分享成功
    case succeed
    /// 取消分享
    case cancel
    /// 分享失败
    case failed
}

/// 分享协议
public protocol FXShare: class {
    
    /// 开始分享
    /// - Parameters:
    ///   - images: 需要分享的图片（包括各种业务场景生成的推广图）
    ///   - copyText: 分享时需要复制到粘贴板的文案
    ///   - type: 分享方式（微信好友、微信朋友圈、QQ、保存图片等）
    ///   - compeletion: 分享完成回调（true=成功 false=失败或者取消）
    func beginShare(images: [UIImage],
                    copyText: String?,
                    types: [FXShareType],
                    compeletion: ((FXShareResult) -> Void)?)
    
    /// 是否可以开始分享（涉及登录、平台授权等判断）
    func shouldBeginShare() -> Bool
    
    /// 开始分享图片
    /// - Parameters:
    ///   - type: 分享方式（微信好友、微信朋友圈、QQ、保存图片等）
    ///   - copyText: 分享时需要复制到粘贴板的文案
    ///   - images: 需要分享的图片（包括各种业务场景生成的推广图）
    ///   - compeletion: 分享完成回调（true=成功 false=失败或者取消）
    func shareImages(images: [UIImage],
                     copyText: String?,
                     type: FXShareType,
                     compeletion: ((FXShareResult) -> Void)?)
    
    /// 复制分享文案到粘贴板
    /// - Parameters:
    ///   - text: 分享文案
    ///   - showSuccessTip: 复制成功是否提示文案
    func copyTextToPasteboard(text: String?, showSuccessTip: Bool)
    
}

public extension FXShare where Self : NSObject {
    
    /// 展示分享方式选择弹窗
    private func showTypeSelectionView(_ selectionView: FXShareTypeSelectionView, inView: UIView) {
        inView.addSubview(selectionView)
        selectionView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        selectionView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            selectionView.alpha = 1.0
        }
    }
    
    public func beginShare(images: [UIImage],
                    copyText: String?,
                    types: [FXShareType],
                    compeletion: ((FXShareResult) -> Void)?) {
        guard shouldBeginShare() else { return }
        
        let selectionView = FXShareTypeSelectionView.init(types: types) { [weak self] (type) in
            self?.shareImages(images: images, copyText: copyText, type: type) { succeed in
                compeletion?(succeed)
            }
        } cancelClosure: {
            compeletion?(.cancel)
        }
        
        if let view = self as? UIView {
            showTypeSelectionView(selectionView, inView: view)
        } else if let vc = self as? UIViewController {
            showTypeSelectionView(selectionView, inView: vc.view)
        }
    }
    
    public func shouldBeginShare() -> Bool {
        return true
    }
    
    public func shareImages(images: [UIImage],
                     copyText: String?,
                     type: FXShareType,
                     compeletion: ((FXShareResult) -> Void)?) {
        AKHud.hideHud()
        
        if type == .album {
            copyTextToPasteboard(text: copyText, showSuccessTip: true)
            FXAlbumHandler.saveToAlbum(imgList: images, showSuccessInfo: true) { (succeed) in
                guard succeed == true else {
                    compeletion?(.failed)
                    return
                }
                compeletion?(.succeed)
            }
        } else if type == .circle {
            copyTextToPasteboard(text: copyText, showSuccessTip: false)
            FXAlbumHandler.saveToAlbum(imgList: images, showSuccessInfo: false) { (succeed) in
                guard succeed == true else {
                    compeletion?(.failed)
                    return
                }
                compeletion?(.succeed)
            }
        } else {
            // 多图图片压缩（微信多图分享有大小限制）
            var fitImgDatas: [Data] = []
            for img in images {
                fitImgDatas.append(UIImage.compressImageData(img, toByte: 300*1024))
            }

            copyTextToPasteboard(text: copyText, showSuccessTip: true)
            FXShareHandler.share(imageDataList: fitImgDatas) { (succeed) in
                guard succeed == true else {
                    compeletion?(.failed)
                    return
                }
                compeletion?(.succeed)
            }
        }
    }
    
    public func copyTextToPasteboard(text: String?, showSuccessTip: Bool) {
        guard let tmpText = text, tmpText.count > 0 else { return }
        
        UIPasteboard.general.string = tmpText
        if showSuccessTip {
            AKHud.showToast(tmpText)
        }
    }
}
