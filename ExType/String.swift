//
//  String.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/23.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension String {
    public var md5: String {
        return MD5(self)
    }
    
    public var base64Encoded: String? {
        let data = self.data(using: String.Encoding.utf8)
        return data?.base64EncodedString(options: [])
    }
    
    public var base64Decoded: String? {
        guard let data = Data(base64Encoded: self, options: []) else { return nil }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    public func regexMatch(text:String) -> [String]? {
        if let e = try? NSRegularExpression(pattern: self, options: .caseInsensitive) {
            let matches = e.matches(in: text, options: .anchored, range:NSMakeRange(0, text.count))
            return matches.map{ (item) in
                let range = item.range
                let startIndex = text.index(text.startIndex, offsetBy: range.location)
                let endIndex = text.index(text.startIndex, offsetBy: range.location+range.length)
                return String(text[startIndex..<endIndex])
            }
        }
        return nil
    }
}

public func ex_uuid() -> String {
    let puuid = CFUUIDCreate(nil)
    if let suuid = CFUUIDCreateString(nil, puuid) {
        return "\(suuid)"
    } else {
        let r0 = ex_random(lower: UInt64(0))
        let r1 = ex_random(lower: UInt64(0))
        let r2 = ex_random(lower: UInt64(0))
        return "\(r0)"+"\(r1)"+"\(r2)"
    }
}
