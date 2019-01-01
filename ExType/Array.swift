//
//  Array.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension Array {
    public func value(at index: Int) -> Element? {
        if index < 0 || index >= self.count {
            return nil
        }

        return self[index]
    }

    public func randomList(count: Int) -> [Element] {
        if self.count <= count { return self.shuffled() }

        return Array(shuffled()[0..<count])
    }

    public func buildDictionary<Key, Value>(toDict combiner: (Element) -> (Key, Value)) -> [Key: Value] {
        var result: [Key: Value] = [:]

        for item in self {
            let keyValue = combiner(item)
            result[keyValue.0] = keyValue.1
        }

        return result
    }
    
    public var tuple2:(Element, Element)? {
        if self.count < 2 { return nil }
        return (self[0], self[1])
    }
    
    public var tuple3:(Element, Element, Element)? {
        if self.count < 3 { return nil }
        return (self[0], self[1], self[2])
    }
    
    public var tuple4:(Element, Element, Element, Element)? {
        if self.count < 4 { return nil }
        return (self[0], self[1], self[2], self[3])
    }
    
    public var tuple5:(Element, Element, Element, Element, Element)? {
        if self.count < 5 { return nil }
        return (self[0], self[1], self[2], self[3], self[4])
    }
    
    public var tuple6:(Element, Element, Element, Element, Element, Element)? {
        if self.count < 6 { return nil }
        return (self[0], self[1], self[2], self[3], self[4], self[5])
    }
    
    public func find(skip:Int, where check:(Element)->Bool) -> Element? {
        var skiped = 0
        for item in self {
            if check(item) {
                if skiped >= skip {
                    return item
                }
                skiped += 1
            }
        }
        
        return nil
    }
    
    public func findIndex(skip:Int, where check:(Element)->Bool) -> Array.Index? {
        var skiped = 0
        for (index, item) in self.enumerated() {
            if check(item) {
                if skiped >= skip {
                    return index
                }
                skiped += 1
            }
        }
        
        return nil
    }
    
    public func findReverse(skip:Int, where check:(Element)->Bool) -> Element? {
        var skiped = 0
        for item in self.reversed() {
            if check(item) {
                if skiped >= skip {
                    return item
                }
                skiped += 1
            }
        }
        
        return nil
    }
    
    public func findIndexReverse(skip:Int, where check:(Element)->Bool) -> Array.Index? {
        var skiped = 0
        for (index, item) in self.enumerated().reversed() {
            if check(item) {
                if skiped >= skip {
                    return index
                }
                skiped += 1
            }
        }
        
        return nil
    }
    
    public func count(check: (Element) throws -> Bool) rethrows -> UInt {
        return try self.reduce(UInt(0), { $0 + (try check($1) ? 1 : 0) })
    }
    
    public func group(isEqual:(_ lhs:Element, _ rhs:Element)->Bool) -> [[Element]] {
        var result:[[Element]] = []
        
        for item in self {
            if let index = result.firstIndex(where: {
                if $0.count == 0 { return false }
                return isEqual($0[0], item)
            }) {
                let old = result[index]
                result[index] = old + [item]
            } else {
                result.append([item])
            }
        }
        
        return result
    }
    
    public func containsAll<T>(of list: [T], equalAs:(Element, T) -> Bool) -> Bool {
        for n in list {
            if !contains(where: { equalAs($0, n) }) {
                return false
            }
        }
        
        return true
    }
    
    public func isAllValueEqual(equalAs:(Element, Element) -> Bool) -> Bool {
        if count < 2 { return true }
        
        for n in stride(from: 1, to: count, by: 1) {
            if !equalAs(self[0], self[n]) { return false }
        }
        
        return true
    }
    
    public func isAllValueSerial(relation:(Element, Element) -> Bool) -> Bool {
        if count < 2 { return true }
        
        for n in stride(from: 1, to: count, by: 1) {
            if !relation(self[n-1], self[n]) { return false }
        }
        
        return true
    }
    
    public func isSame<T>(to list:[T], compare:(Element, T) -> Bool ) -> Bool {
        if count != list.count { return false }
        
        for n in stride(from: 0, to: count, by: 1) {
            if !compare(self[n], list[n]) { return false }
        }
        
        return true
    }
    
    public enum ArrayError : Error {
        case invalidIndex
    }
    
    public func removed(at position:Array.Index) throws -> [Element] {
        if position < 0 || position >= self.count {
            throw ArrayError.invalidIndex
        }
        
        var result = self
        result.remove(at: position)
        
        return result
    }
    
    public func removed(of positions:[Array.Index]) throws -> [Element] {
        var result = self
        for position in positions {
            if position < 0 || position >= self.count {
                throw ArrayError.invalidIndex
            }
            
            result.remove(at: position)
        }
        
        return result
    }
    
    public func removed<T>(by list:[T], compare:(Element, T) -> Bool) -> [Element] {
        var result:[Element] = []
        for n in self {
            if !list.contains(where: { compare(n, $0) }) {
                result.append(n)
            }
        }
        
        return result
    }
}

public extension Array where Element : Equatable {
    public func count(_ element:Element) throws -> UInt {
        return count(check: { $0 == element })
    }
    
    public func group() -> [[Element]] {
        return group(isEqual: { $0 == $1 })
    }
    
    public func containsAll(of list:[Element]) -> Bool {
        return containsAll(of: list, equalAs: { $0 == $1 })
    }
    
    public var isAllValueEqual:Bool {
        return isAllValueEqual(equalAs: { $0 == $1 })
    }
    
    public func removed(by list:[Element]) -> [Element] {
        return removed(by: list, compare: { $0 == $1 })
    }
}

public func ex_stride(from: Double, to toValue: Double, numberOfParts: Double) -> [Double] {
    let step = (toValue - from) / numberOfParts
    return [Double](stride(from: from, to: toValue, by: step))
}

public func ex_stride(from: Int, to toValue: Int, numberOfParts: Int) -> [Int] {
    let step = (toValue - from) / numberOfParts
    return [Int](stride(from: from, to: toValue, by: step))
}

public extension Sequence {
    public func ex_all<T:Numeric>(compute:(Element)->T, _ event:(_ item:(item:Element, index:Int, total:T, remain:T, used:T))->()) {
        let total:T = self.reduce(0) { (prev, curr) -> T in
            return prev + compute(curr)
        }
        
        var used:T = 0
        var index:Int = 0
        self.forEach { (elem) in
            let remain = total - used
            let t = (elem, index, total, remain, used)
            event(t)
            index += 1
            used += compute(elem)
        }
    }
}
