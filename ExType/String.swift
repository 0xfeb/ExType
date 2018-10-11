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
    
    public func index(of offset: Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: offset)
    }
    
    public subscript(_ range: Range<Int>) -> String {
        let start = index(of: range.lowerBound)
        let end = index(of: range.upperBound)
        return String(self[start..<end])
    }
    
    public var dict:[String: Any]? {
        return ex_json(text: self)
    }
    
    public func apart2(_ s:String) -> (String, String)? {
        let list = self.components(separatedBy: s)
        if list.count < 2 {
            return nil
        }
        
        return (list[0], list[1])
    }
    
    public func apart3(_ s:String) -> (String, String, String)? {
        let list = self.components(separatedBy: s)
        if list.count < 3 {
            return nil
        }
        
        return (list[0], list[1], list[2])
    }
    
    public func apart4(_ s:String) -> (String, String, String, String)? {
        let list = self.components(separatedBy: s)
        if list.count < 4 {
            return nil
        }
        
        return (list[0], list[1], list[2], list[3])
    }
    
    public func apart5(_ s:String) -> (String, String, String, String, String)? {
        let list = self.components(separatedBy: s)
        if list.count < 5 {
            return nil
        }
        
        return (list[0], list[1], list[2], list[3], list[4])
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
