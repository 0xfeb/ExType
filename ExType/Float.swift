//
//  Float.swift
//  ExType
//
//  Created by 王渊鸥 on 2019/1/5.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics

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

public func ~(_ lhs:CGFloat, _ rhs:CGFloat) -> Bool {
    let distance = lhs - rhs
    return distance < 0.00001 && distance > -0.00001
}

public func ~(_ lhs:CGPoint, _ rhs:CGPoint) -> Bool {
    return (lhs.x ~ rhs.x) && (lhs.y ~ rhs.y)
}

public func ~(_ lhs:CGSize, _ rhs:CGSize) -> Bool {
    return (lhs.width ~ rhs.width) && (lhs.height ~ rhs.height)
}

public func ~(_ lhs:CGRect, _ rhs:CGRect) -> Bool {
    return (lhs.origin ~ rhs.origin) && (lhs.size ~ rhs.size)
}
