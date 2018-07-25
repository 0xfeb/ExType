//
//  Random.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

private func arc4random<T: BinaryInteger> (type: T.Type) -> T {
    var number: T = 0
    arc4random_buf(&number, MemoryLayout<T>.size)
    return number
}

public func ex_random<T: FixedWidthInteger>(lower: T = T.min, upper: T = T.max) -> T {
    var limit: T
    let range = upper - lower
    var number = arc4random(type: T.self)
    if range > T(T.max) {
        limit = 1 + ~range
    } else {
        limit = ((T.max - (range * 2)) + 1) % range
    }
    while number < limit {
        number = arc4random(type: T.self)
    }
    return (number % range) + lower
}
