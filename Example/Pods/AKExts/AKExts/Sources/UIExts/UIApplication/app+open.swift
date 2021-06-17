//
//  app+open.swift
//  AKExts
//
//  Created by edz on 4/2/21.
//

import AKMeta

// MARK: - UIApplication扩展
public extension AKMeta where Meta: UIApplication {
    
    /// 打开URL
    /// - Parameter url: 地址
    func open(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [.universalLinksOnly : false], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    /// 打开系统设置
    func openSysSetting() {
        let key = UIApplication.openSettingsURLString
        guard let u = URL.init(string: key) else {
            return
        }
        UIApplication.shared.openURL(u)
    }
}
