//
//  Sequence.swift
//  ExType
//
//  Created by 王渊鸥 on 2019/1/5.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import Foundation

public extension Sequence {
    func first(skip:Int, where predicate:(Element) throws ->Bool) rethrows -> Element? {
        var skiped = 0
        for item in self {
            if try predicate(item) {
                if skiped >= skip {
                    return item
                }
                skiped += 1
            }
        }
        
        return nil
    }

    func last(skip:Int, where predicate:(Element) throws ->Bool) rethrows -> Element? {
        var skiped = 0
        for item in self.reversed() {
            if try predicate(item) {
                if skiped >= skip {
                    return item
                }
                skiped += 1
            }
        }
        
        return nil
    }
    
    func count(check: (Element) throws -> Bool) rethrows -> UInt {
        return try self.reduce(UInt(0), { $0 + (try check($1) ? 1 : 0) })
    }
    
    func containsAll<T>(in list: [T], equal predicate:(Element, T) throws -> Bool) rethrows -> Bool {
        for n in list {
            if try !contains(where: { try predicate($0, n) }) {
                return false
            }
        }
        
        return true
    }
    

}

extension Sequence where Element : Equatable {
    func count(_ element:Element) -> UInt {
        return count(check: { $0 == element })
    }
    
    func containsAll(in list:[Element]) -> Bool {
        return containsAll(in: list, equal: { $0 == $1 })
    }
}
