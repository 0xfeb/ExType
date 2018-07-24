//
//  Random.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

private func arc4random<T:BinaryInteger> (type: T.Type) -> T {
    var r: T = 0
    arc4random_buf(&r, MemoryLayout<T>.size)
    return r
}

public func ex_random<T:FixedWidthInteger>(lower:T = T.min, upper:T = T.max) -> T {
    var m: T
    let u = upper - lower
    var r = arc4random(type: T.self)
    if u > T(T.max) {
        m = 1 + ~u
    } else {
        m = ((T.max - (u * 2)) + 1) % u
    }
    while r < m {
        r = arc4random(type: T.self)
    }
    return (r % u) + lower
}

