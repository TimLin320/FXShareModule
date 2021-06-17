//
//  dvc+info.swift
//  AKExts
//
//  Created by edz on 3/22/21.
//

import AKMeta
import AdSupport
import CoreTelephony
import KeychainAccess

fileprivate let KEY_CHAIN_SERVICE_NAME = "com.aspire.np"
fileprivate let UUID_KEY = "UUID_KEY"
fileprivate let DEVICE_TYPE_KEY = "DEVICE_TYPE_KEY"

/// 通信（手机运营商）类型
public enum TelecomType {
    case unowned
    case CM    // 中国移动 CMCC
    case CT    // 中国电信 CTCC
    case CU    // 中国联通 CUCC
}

/// 设备扩展 - 信息
public extension AKMeta where Meta: UIDevice {
    
    /// 顶部是否具有凹槽
    /// - Returns: 是则刘海儿屏
    static func hasNotch() -> Bool {
        if #available(iOS 13.0,  *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
        } else {
            if #available(iOS 11.0, *) {
                return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
            }
        }
        return false
    }
    
    /// 获得idfa
    /// - Returns: String
    static func idfa() -> String? {
        guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else {
            return nil
        }
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    /// 获得uuid
    /// - Returns: String
    static func uuid() -> String {
        // 先从keychain查询
        let kchain = Keychain(service: KEY_CHAIN_SERVICE_NAME)
        if let uuid = kchain[UUID_KEY] {
            return uuid
        }
        // 其次从设备获取
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString else {
            fatalError()
        }
        kchain[UUID_KEY] = uuid
        return uuid
    }
    
    /// 获得app version
    /// - Returns: String
    static func appVersion() -> String {
        guard let info = Bundle.main.infoDictionary else {
            return ""
        }
        return info["CFBundleShortVersionString"] as! String
    }
    
    /// build version
    /// - Returns: 构建版本
    static func buildVersion() -> String {
        guard let info = Bundle.main.infoDictionary else {
            return ""
        }
        return info["CFBundleVersion"] as! String
    }
    
    /// 获得 系统 版本
    /// - Returns: String
    static func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// 机型
    /// - Returns: 机型原始串
    static func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
            
        }
        return identifier
    }
    
    // MARK: UIDevice 获取关于手机设备的数据业务信息 包含网络制式、运营商名字、移动国家码、移动网络码、ISO国家代码、是否允许VoIP等
    /// 获取手机设备的数据业务信息
    /// - Returns: String
    static func teleInfo() -> CTCarrier? {
        return CTTelephonyNetworkInfo().subscriberCellularProvider
    }
    
    /// 获取手机运营商名字
    /// - Returns: String
    static func telecomName() -> String? {
        let carrier = teleInfo()
        // 需要注意的是，如果你的手机内没有sim卡的时候，这个时候获取到的运营商名称为手机的默认运营商，所以先做一个没有运营商的判断
        guard (carrier?.isoCountryCode) != nil else {
            return nil // 没有sim卡，无运营商
        }
        return carrier?.carrierName
    }
    
    /// 获得手机运营商类型
    /// - Returns: String
    static func telecomType() -> TelecomType {
        guard let name = telecomName() else {
            return .unowned
        }
        switch name {
        case "中国移动":
            return .CM
        case "中国电信":
            return .CT
        case "中国联通":
            return .CU
        default:
            return .unowned
        }
    }
    
    /// 屏幕是否窄于基准
    /// - Parameter wd: 基准
    /// - Returns: 是否小于标准
    static func isScreenNarrow(_ for: CGFloat = 320) -> Bool {
        guard UIScreen.main.bounds.width <= `for` else {
            return false
        }
        return true
    }
}

