//
//  str+regular.swift
//  AKExts
//
//  Created by edz on 2/20/21.
//

import AKMeta

// 正则表达式
enum RegValidType: String, CaseIterable {
    case phone = "^(1[3-9])\\d{9}$"                         // 手机号码
    case digital = "[0-9]*"                                 // 全数字
    case password = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"      // 密码
    case inviteCode = "^[A-Za-z0-9]{6,8}$"                      // 邀请码
    case vertifyCode = "^[0-9]{5,6}$"                           // 验证码
    case vertifyColor = "^(#｜0x｜0X)[0-9a-fA-F]{6}$"            // 检测颜色
}

// MARK: - 字符串扩展 - 正则表达式
public extension AKMeta where Meta == String {
    /// 随机字符串(默认6位)
    static func random(_ len: Int = 6) -> String {
        var res = String.init(format: "%d", arc4random_uniform(9) + 1)
        for _ in 1...len {
            let romStr = String.init(format: "%d", arc4random_uniform(10))
            res = res.appending(romStr)
        }
        return res
    }
    /// 是否为全数字
    func isValidDigit() -> Bool {
        return isValid(type: .digital)
    }
    /// 电话号码是否有效
    func isValidPhoneNumber() -> Bool {
        return isValid(type: .phone)
    }
    /// 密码是否有效
    func isValidPassword() -> Bool {
        return isValid(type: .password)
    }
    /// 邀请码是否有效
    func isValidInviteCode() -> Bool {
        return isValid(type: .inviteCode)
    }
    /// 验证码是否有效
    func isValidVerifyCode() -> Bool {
        return isValid(type: .vertifyCode)
    }
    /// 检测是否是颜色
    func isValidVerifyColor() -> Bool {
        return isValid(type: .vertifyColor)
    }
    /// 用正则检查是否
    private func isValid(type:RegValidType) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", type.rawValue).evaluate(with: self.base)
    }
    /// 正则匹配(单个)
    func match(_ pattern: String) -> String? {
        guard let matchRange = self.base.range(of: pattern,
                                       options: .regularExpression,
                                       range: self.base.startIndex ..< self.base.endIndex,
                                       locale: nil) else {

            return nil
        }
        return String(self.base[matchRange])
    }
    /// 正则匹配(多个)
    func matchs(_ pattern: String) -> [String] {
        /// 该方法，#([0-9|a-zA-Z]{6})# 识别 #123456# 结果是 123456 不会带上两端#
        let query = base
        do {
            let regexExp = try NSRegularExpression(pattern: pattern, options: [])
            var results = [String]()
            regexExp.enumerateMatches(in: query, options: [], range: NSMakeRange(0, query.utf16.count)) { result, flags, stop in
                if let r = result?.range(at: 1), let range = Range(r, in: query) {
                    results.append(String(query[range]))
                }
            }
            return results
        } catch {}
        return []
    }
    /// 正则匹配(Range)
    func matchRange(_ pattern: String) -> NSRange? {
        guard let matchRange = self.base.range(of: pattern,
                                       options: .regularExpression,
                                       range: self.base.startIndex ..< self.base.endIndex,
                                       locale: nil) else {

            return nil
        }
        let ms = String(self.base[matchRange])
        return (self.base as NSString).range(of: ms)
    }
    
    /// 拨打电话
    func mkCall() {
        guard let uri = URL(string: "telprompt://" + base),
              UIApplication.shared.canOpenURL(uri) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(uri, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(uri)
        }
    }
}
