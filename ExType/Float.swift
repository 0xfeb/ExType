//
//  Float.swift
//  ExType
//
//  Created by 王渊鸥 on 2019/1/5.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import Foundation

public func % (_ lhs:Double, _ rhs:Double) -> Double {
    return lhs.remainder(dividingBy: rhs)
}

public func % (_ lhs:Float, _ rhs:Float) -> Float {
    return lhs.remainder(dividingBy: rhs)
}

infix operator ~

public func ~(_ lhs:Float, _ rhs:Float) -> Bool {
    let distance = lhs - rhs
    return distance < 0.00001 && distance > -0.00001
}

public func ~(_ lhs:Double, _ rhs:Double) -> Bool {
    let distance = lhs - rhs
    return distance < 0.00001 && distance > -0.00001
}
