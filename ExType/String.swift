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
    
    public func split(size:Int) -> [String] {
        if size < 1 { return [self] }
        
        return stride(from: 0, to: self.count, by: size)
            .compactMap({ (position) -> String? in
                return self.subString(from: position, size: size)
            })
    }
    
    public func split(_ seperater:String, limit:Int) -> [String] {
        if limit < 2 { return [self] }
        
        let c = self.components(separatedBy: seperater)
        if c.count <= limit { return c }
        
        var result = c[..<(limit-1)]
        result.append(c[(limit-1)...].joined(separator: seperater))
        
        return Array(result)
    }
    
    public func subString(from:Int, size:Int) -> String? {
        guard let indexLow = index(startIndex, offsetBy: from, limitedBy: endIndex), indexLow != endIndex else {
            return nil
        }
        
        let indexHigh = index(indexLow, offsetBy: size, limitedBy: endIndex) ?? endIndex
        
        return String(self[indexLow..<indexHigh])
    }
    
    public func char(at position:Int) -> Character? {
        if let index = self.index(self.startIndex, offsetBy: position, limitedBy: self.endIndex), index != endIndex {
            return self[index]
        }
        return nil
    }
    
    public func fixFront(fix:Character, textLength:Int) -> String {
        let fixSize = textLength - count
        if fixSize > 0 {
            return String(repeating: fix, count: fixSize) + self
        } else {
            return self
        }
    }
    
    public func fixBack(fix:Character, textLength:Int) -> String {
        let fixSize = textLength - count
        if fixSize > 0 {
            return self + String(repeating: fix, count: fixSize)
        } else {
            return self
        }
    }
    
    public func isFormat(start:Character?, middle:String?, end:Character?) -> Bool {
        for (index, char) in self.enumerated() {
            if index == 0 {
                if let start = start {
                    if char != start { return false }
                }
            } else if index == count - 1 {
                if let end = end {
                    if char != end { return false }
                }
            } else {
                if let middle = middle {
                    if !middle.contains(char) { return false }
                }
            }
        }
        return true
    }
    
    public func count(_ character:Character) -> UInt {
        return self.reduce(UInt(0), { $0 + ($1 == character ? 1 : 0) })
    }
    
    public func count(check: (Character) throws ->Bool ) rethrows -> UInt {
        return try self.reduce(UInt(0), { $0 + (try check($1) ? 1 : 0) })
    }
    
    public func trim(characters:String = " ") -> String {
        return trimLeft(characters: characters)
            .trimRight(characters: characters)
    }
    
    public func trimLeft(characters:String = " ") -> String {
        var offset = self.startIndex
        for (index, char) in self.enumerated() {
            if characters.contains(char) {
                offset = self.index(self.startIndex, offsetBy: index+1)
            } else {
                break
            }
        }
        
        if offset == self.startIndex {
            return self
        } else {
            return String(self[offset...])
        }
    }
    
    public func trimRight(characters:String = " ") -> String {
        return String(String(self.reversed()).trimLeft(characters:characters).reversed())
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
