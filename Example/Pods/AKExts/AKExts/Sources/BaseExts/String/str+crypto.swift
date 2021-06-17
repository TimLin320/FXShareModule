//
//  str+crypto.swift
//  AKExts
//
//  Created by edz on 2/20/21.
//

import AKMeta
import CryptoSwift
import CommonCrypto

// MARK: - 字符串扩展 - Hash摘要/密文
public extension AKMeta where Meta == String {
    
    /**
     md5摘要
     */
    func md5() -> String {
        let str = self.base.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.base.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        return String(format: hash as String)
    }
    
    /**
     base64编码
     */
    func base64Encode() -> String? {
        if let data = self.base.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    /**
     base64解码
     */
    func base64Decode() -> String? {
        if let data = Data(base64Encoded: self.base) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    /**
     AES对称加密
     */
    func aesEncrypt(_ key: String) -> String? {
        // key必须是16位的整数倍字符
        do {
            let aes = try AES(key: key.bytes, blockMode: ECB())
            let encrypted = try aes.encrypt(self.base.bytes)
            guard encrypted.count > 0 else {
                return nil
            }
            let data = Data(encrypted)
            return data.toHexString().uppercased()
        } catch {}
        return nil
    }
    
    /**
     AES对称解密
     */
    func aesDecrypt(_ key:String) -> String? {
        let passLength = 16
        var  password: String = String(key.prefix(passLength))
        while password.count <  passLength {
            password = password + "0"
        }
        let data = Data(hex: self.base)
        guard let aes = try? AES(key: password.bytes, blockMode: ECB(),padding: .pkcs5),
            let decryptData =  try? data.decrypt(cipher: aes),
            let decryptedString = String(data: decryptData, encoding: .utf8)
            else {
            return nil
        }
        return decryptedString
    }
}
