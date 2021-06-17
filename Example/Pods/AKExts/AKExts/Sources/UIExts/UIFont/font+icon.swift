//
//  font+icon.swift
//  AKExts
//
//  Created by edz on 4/14/21.
//

import AKMeta

/// icon-font 协议
public protocol AKIconFontable {
    /// 字体名称<equal to .ttf file name>
    var name: String { get }
    /// 资源路径
    var path: String { get }
    /// 字体编码<etc. rawValue>
    var asCode: String { get }
    /// 加载字体
    func loadFont() -> Bool
}
/// 默认实现
public extension AKIconFontable {
    
    /// 加载字体
    /// - Returns: 加载结果
    @discardableResult
    func loadFont() -> Bool {
        if UIFont.fontNames(forFamilyName: name).isEmpty == false {
            return true
        }
        if path.isEmpty {
            return false
        }
        guard let fontData = NSData(contentsOfFile: path), let dataProvider = CGDataProvider(data: fontData), let cgFont = CGFont(dataProvider) else {
            return false
        }
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(cgFont, &error) {
            var errorDescription: CFString = "Unknown" as CFString
            if let takeUnretainedValue = error?.takeUnretainedValue() {
                errorDescription = CFErrorCopyDescription(takeUnretainedValue)
            }
            print("Unable to load \(path): \(errorDescription)")
            return false
        }
        return true
    }
}
