//
//  String.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/23.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension String {
    var md5: String {
        return MD5(self)
    }

    var base64Encoded: String? {
        let data = self.data(using: String.Encoding.utf8)
        return data?.base64EncodedString(options: [])
    }

    var base64Decoded: String? {
        guard let data = Data(base64Encoded: self, options: []) else { return nil }
        return String(data: data, encoding: String.Encoding.utf8)
    }

    func regex(text: String) -> [String]? {
        if let expression = try? NSRegularExpression(pattern: self, options: [.anchorsMatchLines]) {
            let range = NSRange(location: 0, length: text.count)
            let matches = expression.matches(in: text, options: [], range: range)
            var result:[String] = []
            for item in matches {
                for n in 0..<item.numberOfRanges {
                    let range = item.range(at: n)
                    let startIndex = text.index(text.startIndex, offsetBy: range.location)
                    let endIndex = text.index(text.startIndex, offsetBy: range.location+range.length)
                    result.append(String(text[startIndex..<endIndex]))
                }
            }
            result.remove(at: 0)
            return result
        }
        return nil
    }
    
    func replace(range:NSRange, text:StringLiteralType) -> String {
        let mutString = NSMutableString(string: self)
        return mutString.replacingCharacters(in: range, with: text)
    }
    
    func isMatch(text:String) -> Bool {
        guard let expression = try? NSRegularExpression(pattern: self, options: [.anchorsMatchLines]) else { return false }
        
        let range = NSRange(location: 0, length: text.count)
        return expression.firstMatch(in: text, options: [], range: range) != nil
    }
    
    func regexOutput(source:String, templete:String) -> String? {
        guard let expression = try? NSRegularExpression(pattern: self, options: [.anchorsMatchLines]) else { return nil }
        
        let range = NSRange(location: 0, length: source.count)
        return expression.stringByReplacingMatches(in: source, options: [], range: range, withTemplate: templete)
    }

    var trimed : String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func index(at offset: Int) -> String.Index? {
        guard let result = self.index(self.startIndex, offsetBy: offset, limitedBy: self.endIndex) else { return nil }
        if result < self.startIndex { return nil }
        return result
    }
    
    var jsonDictionary:[String : Any]? {
        if let data = self.data(using: String.Encoding.utf8) {
            if let dict = try? JSONSerialization.jsonObject(with: data, options: []) {
                return dict as? [String: Any]
            }
        }
        
        return nil
    }
    
    subscript(_ range: Range<Int>) -> String? {
        guard let start = index(at: range.lowerBound),
            let end = index(at: range.upperBound) else { return nil }
        return String(self[start..<end])
    }
    
    subscript(_ range: ClosedRange<Int>) -> String? {
        guard let start = index(at: range.lowerBound),
            let end = index(at: range.upperBound) else { return nil }
        return String(self[start...end])
    }
    
    subscript(_ range: PartialRangeFrom<Int>) -> String? {
        guard let start = index(at: range.lowerBound) else { return nil }
        return String(self[start...])
    }
    
    subscript(_ range: PartialRangeUpTo<Int>) -> String? {
        guard let end = index(at: range.upperBound) else { return nil }
        return String(self[..<end])
    }
    
    subscript(_ position: Int) -> Character? {
        if let index = self.index(self.startIndex, offsetBy: position, limitedBy: self.endIndex), index != endIndex {
            return self[index]
        }
        return nil
    }
    
    func split(size:Int) -> [String] {
        if size < 1 { return [self] }
        
        return stride(from: 0, to: self.count, by: size)
            .compactMap({ (position) -> String? in
                return self.subString(from: position, size: size)
            })
    }
    
    func split(_ seperater:String, limit:Int) -> [String] {
        if limit < 2 { return [self] }
        
        var result:[String] = []
        var current:String = ""
        
        for c in self {
            if result.count == limit - 1 {
                current.append(c)
            } else {
                if seperater.contains(c) {
                    if current.count > 0 {
                        result.append(current)
                        current = ""
                    }
                } else {
                    current.append(c)
                }
            }
        }
        
        if current.trim(characters: seperater).count > 0 {
            result.append(current)
        }
        
        return result
    }
    
    func subString(from:Int, size:Int) -> String? {
        guard let indexLow = index(startIndex, offsetBy: from, limitedBy: endIndex), indexLow != endIndex else {
            return nil
        }
        
        let indexHigh = index(indexLow, offsetBy: size, limitedBy: endIndex) ?? endIndex
        
        return String(self[indexLow..<indexHigh])
    }
    
    func fixFront(fix:Character, textLength:Int) -> String {
        let fixSize = textLength - count
        if fixSize > 0 {
            return String(repeating: fix, count: fixSize) + self
        } else {
            return self
        }
    }
    
    func fixBack(fix:Character, textLength:Int) -> String {
        let fixSize = textLength - count
        if fixSize > 0 {
            return self + String(repeating: fix, count: fixSize)
        } else {
            return self
        }
    }
    
    func isFormat(start:Character?, middle:String?, end:Character?) -> Bool {
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
    
    func count(_ character:Character) -> UInt {
        return self.reduce(UInt(0), { $0 + ($1 == character ? 1 : 0) })
    }
    
    func count(check: (Character) throws ->Bool ) rethrows -> UInt {
        return try self.reduce(UInt(0), { $0 + (try check($1) ? 1 : 0) })
    }
    
    func trim(characters:String = " ") -> String {
        return trimLeft(characters: characters)
            .trimRight(characters: characters)
    }
    
    func trimLeft(characters:String = " ") -> String {
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
    
    func trimRight(characters:String = " ") -> String {
        return String(String(self.reversed()).trimLeft(characters:characters).reversed())
    }
    
    func removed(at position:Int) -> String {
        guard let index = self.index(at: position) else { return self }
        if index < self.startIndex || index >= self.endIndex { return self }
        
        var result = self
        result.remove(at: index)
        
        return result
    }
    
    func removed(at positions:[Int]) throws -> String {
        var result = self
        for position in positions.sorted(by: >) {
            guard let index = self.index(at: position) else { continue }
            if index < self.startIndex || index >= self.endIndex { continue }
            
            result.remove(at: index)
        }
        
        return result
    }
    
    func find(_ text:String) -> [String] {
        return self.components(separatedBy: text)
    }
    
    private func apartIn(pos:Int, count:Int) -> [String] {
        if pos == 0 {
            return ["", self[count...] ?? self]
        } else if pos >= self.count - count {
            return [self[..<pos] ?? self, ""]
        } else {
            return [
                self[..<pos] ?? self,
                self[(pos+count)...] ?? self
            ]
        }
    }
    
    func testF(_ text:String) -> Int? {
        var loc:Int?
        let leftCount = self.count - text.count
        for n in (0...leftCount).reversed() {
            let start = n-text.count+1
            let end = start + text.count
            let sub = self[start..<end]
            if sub == text {
                loc = n
                break
            }
        }
        
        return loc
    }
    
    func findFirst(_ text:String) -> [String] {
        let leftCount = self.count - text.count
        if leftCount <= 0 {
            return [self]
        }
        
        var loc:Int?
        for n in 0...leftCount {
            let sub = self[n..<(n+text.count)]
            if sub == text {
                loc = n
                break
            }
        }
        
        guard let apartLoc:Int = loc else { return [self] }
        return apartIn(pos: apartLoc, count: text.count)
    }
    
    func findLast(_ text:String) -> [String] {
        let leftCount = self.count - text.count
        if leftCount <= 0 {
            return [self]
        }
        
        var loc:Int?
        for n in (0...leftCount).reversed() {
            let start = n-text.count+1
            let end = start + text.count
            let sub = self[start..<end]
            if sub == text {
                loc = n
                break
            }
        }
        
        guard let apartLoc = loc else { return [self] }
        return apartIn(pos: apartLoc, count: text.count)
    }
}


