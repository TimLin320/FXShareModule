//
//  FXShareSysItem.swift
//  FXShare
//
//  Created by Lyman on 2021/5/14.
//

import UIKit

/// 系统分享Item
public class FXShareSysItem: NSObject, UIActivityItemSource {
    
    /// UIImage图片
    var image: UIImage? = nil
    /// Data图片
    var imageData : Data? = nil
    /// 路径
    let url : URL
    
    init(image: UIImage, locaUrl: URL) {
        self.image = image
        self.url = locaUrl
        super.init()
    }
    
    init(imageData: Data, locaUrl: URL) {
        self.imageData = imageData
        self.url = locaUrl
        super.init()
    }
    
    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        if let imgData = imageData {
            return imgData
        }
        if let img = image {
            return img
        }
        return Data()
    }

    public func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return url
    }

    public func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return ""
    }
}
