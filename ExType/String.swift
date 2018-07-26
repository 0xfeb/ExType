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

    public func regexMatch(text: String) -> [String]? {
        if let expression = try? NSRegularExpression(pattern: self, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: text.count)
            let matches = expression.matches(in: text, options: .anchored, range: range)
            return matches.map({ (item) in
                let range = item.range
                let startIndex = text.index(text.startIndex, offsetBy: range.location)
                let endIndex = text.index(text.startIndex, offsetBy: range.location+range.length)
                return String(text[startIndex..<endIndex])
            })
        }
        return nil
    }

    public var trimed : String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

public func ex_uuid() -> String {
    let puuid = CFUUIDCreate(nil)
    if let suuid = CFUUIDCreateString(nil, puuid) {
        return "\(suuid)"
    } else {
        let random0 = ex_random(lower: UInt64(0))
        let random1 = ex_random(lower: UInt64(0))
        let random2 = ex_random(lower: UInt64(0))
        return "\(random0)"+"\(random1)"+"\(random2)"
    }
}
