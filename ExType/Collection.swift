//
//  Collection.swift
//  ExType
//
//  Created by 王渊鸥 on 2019/1/5.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import Foundation

public enum CollectionError : Error {
    case invalidIndex
}

public struct NearItem<T> {
    var prev:T?
    var current:T
    var next:T?
    
    init(_ prev:T?, _ current:T, _ next:T?) {
        self.prev = prev
        self.current = current
        self.next = next
    }
}

extension NearItem : Equatable where T:Equatable {
    public static func == (lhs: NearItem<T>, rhs: NearItem<T>) -> Bool {
        return lhs.prev==rhs.prev && lhs.current==rhs.current && lhs.next==rhs.next
    }
}

public extension Collection {
    func value(at index:Self.Index) -> Element? {
        if index < self.startIndex || index >= self.endIndex {
            return nil
        }
        
        return self[index]
    }
    
    func mapDict<Key, Value>(_ predicate: (Element) throws -> (Key, Value)) rethrows -> [Key: Value] {
        var result: [Key: Value] = [:]
        
        for item in self {
            let keyValue = try predicate(item)
            result[keyValue.0] = keyValue.1
        }
        
        return result
    }
    
    var tuple2:(Element, Element)? {
        if self.count < 2 { return nil }
        return (self[self.startIndex],
                self[self.index(self.startIndex, offsetBy: 1)])
    }
    
    var tuple3:(Element, Element, Element)? {
        if self.count < 3 { return nil }
        return (self[self.startIndex],
                self[self.index(self.startIndex, offsetBy: 1)],
                self[self.index(self.startIndex, offsetBy: 2)])
    }
    
    var tuple4:(Element, Element, Element, Element)? {
        if self.count < 4 { return nil }
        return (self[self.startIndex],
                self[self.index(self.startIndex, offsetBy: 1)],
                self[self.index(self.startIndex, offsetBy: 2)],
                self[self.index(self.startIndex, offsetBy: 3)])
    }
    
    var tuple5:(Element, Element, Element, Element, Element)? {
        if self.count < 5 { return nil }
        return (self[self.startIndex],
                self[self.index(self.startIndex, offsetBy: 1)],
                self[self.index(self.startIndex, offsetBy: 2)],
                self[self.index(self.startIndex, offsetBy: 3)],
                self[self.index(self.startIndex, offsetBy: 4)])
    }
    
    var tuple6:(Element, Element, Element, Element, Element, Element)? {
        if self.count < 6 { return nil }
        return (self[self.startIndex],
                self[self.index(self.startIndex, offsetBy: 1)],
                self[self.index(self.startIndex, offsetBy: 2)],
                self[self.index(self.startIndex, offsetBy: 3)],
                self[self.index(self.startIndex, offsetBy: 4)],
                self[self.index(self.startIndex, offsetBy: 5)])
    }
    
    func firstIndex(skip:Int, where predicate:(Element) throws ->Bool) rethrows -> Self.Index? {
        var skiped = 0
        for n in self.indices {
            let item = self[n]
            if try predicate(item) {
                if skiped >= skip {
                    return n
                }
                skiped += 1
            }
        }
        
        return nil
    }
    
    func lastIndex(skip:Int, where predicate:(Element) throws ->Bool) rethrows -> Self.Index? {
        var skiped = 0
        for n in self.indices.reversed() {
            let item = self[n]
            if try predicate(item) {
                if skiped >= skip {
                    return n
                }
                skiped += 1
            }
        }
        
        return nil
    }
    
    func group(isEqual:(_ lhs:Element, _ rhs:Element) throws ->Bool) rethrows -> [[Element]] {
        var result:[[Element]] = []
        
        for item in self {
            if let index = try result.firstIndex(where: {
                if $0.count == 0 { return false }
                return try isEqual($0[0], item)
            }) {
                let old = result[index]
                result[index] = old + [item]
            } else {
                result.append([item])
            }
        }
        
        return result
    }
    
    func areEqual(_ predicate:(Element, Element) throws -> Bool) rethrows -> Bool {
        if count < 2 { return true }
        
        for n in stride(from: 1, to: count, by: 1) {
            if try !predicate(self[self.startIndex], self[self.index(self.startIndex, offsetBy: n)]) { return false }
        }
        
        return true
    }
    
    func areSerial(_ predicate:(Element, Element) throws -> Bool) rethrows -> Bool {
        if count < 2 { return true }
        
        for n in stride(from: 1, to: count, by: 1) {
            if try !predicate(self[self.index(self.startIndex, offsetBy: n-1)], self[self.index(self.startIndex, offsetBy: n)]) { return false }
        }
        
        return true
    }
    
    var nearList:[NearItem<Self.Element>] {
        var result:[NearItem<Self.Element>] = []
        
        for n in stride(from: 0, to: count, by: 1) {
            let item = NearItem(self.value(at: self.index(self.startIndex, offsetBy: n-1)),
                                self[self.index(self.startIndex, offsetBy: n)],
                                self.value(at: self.index(self.startIndex, offsetBy: n+1)))
            result.append(item)
        }
        
        return result
    }
    
    func forEachNear(_ predicate:(_ item:NearItem<Self.Element>) throws -> ()) rethrows {
        for n in stride(from: 0, to: count, by: 1) {
            let item = NearItem(self.value(at: self.index(self.startIndex, offsetBy: n-1)),
                                self[self.index(self.startIndex, offsetBy: n)],
                                self.value(at: self.index(self.startIndex, offsetBy: n+1)))
            try predicate(item)
        }
    }
}

public extension Collection where Element : Equatable {
    func group() -> [[Element]] {
        return group(isEqual: { $0 == $1 })
    }
    
    var areEqual:Bool {
        return areEqual({ $0 == $1 })
    }
}

public struct EnumItem<T:Numeric> {
    var index:Int
    var element:T
    var amount:T
    var total:T
}

public extension Collection where Element : Numeric {
    func forEachScore(_ predicate:(EnumItem<Element>) throws ->()) rethrows {
        let total = self.reduce(0, +)
        var used:Self.Element = 0
        var n = 0
        try self.forEach{ (elem) in
            used += elem
            let t = EnumItem(index: n, element: elem, amount: used, total: total)
            try predicate(t)
            n += 1
        }
    }
}
