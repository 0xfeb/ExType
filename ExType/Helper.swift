//
//  Helper.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension Int {
    public var chineseDescription: String {
        if self > 100_000_000 {
            let n = Float(self) / 100_000_000
            return String(format:"%.1f亿", n)
        } else if self > 10_000 {
            let n = Float(self) / 10_000
            return String(format:"%.1f万", n)
        } else if self > 1_000 {
            let n = Float(self) / 1_000
            return String(format:"%.0f千", n)
        } else {
            return "\(self)"
        }
    }
}

public extension Comparable {
    public func limit(min:Self,  max:Self) -> Self {
        if self < min { return min }
        if self > max { return max }
        return self
    }
}

public extension Range where Bound : SignedInteger&UnsignedInteger {
    public init(incStart:Bound, incEnd:Bound) {
        self.init(uncheckedBounds:(incStart, incEnd))
    }
    
    public init(incStart:Bound, excEnd:Bound) {
        self.init(uncheckedBounds:(incStart, excEnd-1))
    }
    
    public init(excStart:Bound, incEnd:Bound) {
        self.init(uncheckedBounds:(excStart+1, incEnd))
    }
    
    public init(excStart:Bound, excEnd:Bound) {
        self.init(uncheckedBounds:(excStart+1, excEnd-1))
    }
}

public func ex_set<T>(_ item:T, _ action:(T)->Void) -> T {
    action(item)
    return item
}
