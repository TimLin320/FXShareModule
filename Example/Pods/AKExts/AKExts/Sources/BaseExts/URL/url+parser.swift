//
//  url+parser.swift
//  AKExts
//
//  Created by edz on 2/20/21.
//

import AKMeta

// MARK: - URL扩展
extension URL: AKMetaProtocol {}
public extension AKMeta where Meta == URL {
    /// scheme://
    var scheme: String {
        let schm = base.scheme
        var sub_schm: String?
        if base.absoluteString.contains("://") {
            sub_schm = NSString(string: base.absoluteString).components(separatedBy: "://").first
        }
        return "\(schm ?? (sub_schm ?? "http"))"
    }
    /// host/path
    var hostPath: String {
        let origin = base.host
        var sub_hostPath: String?
        // 如果失败则从path解析
        if origin == nil && NSString(string: base.path).contains("://") {
            if let suffix = NSString(string: base.path).components(separatedBy: "://").last {
                sub_hostPath = suffix
                if suffix.contains("?"), let prefix = NSString(string: suffix).components(separatedBy: "?").first {
                    sub_hostPath = prefix
                }
            }
        }
        guard let ori = origin else {
            return sub_hostPath ?? ""
        }
        return "\(ori)\(base.path)"
    }
    /// scheme://host/path
    var schemeHostPath: String {
        return "\(scheme)://\(hostPath)"
    }
    /// query map
    var queryMap: [String: String] {
        guard let coms = URLComponents(string: self.base.absoluteString), let its = coms.queryItems else {
            return [:]
        }
        var tmp: [String: String] = [:]
        for it in its {
            tmp[it.name] = it.value
        }
        return tmp
    }
}
