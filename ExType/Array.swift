//
//  Array.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension Array {
    public func value(at:Int) -> Element? {
        if at < 0 || at >= self.count {
            return nil
        }
        
        return self[at]
    }
    
    public func randomList(count:Int) -> [Element] {
        if self.count <= count { return self.shuffled() }

        return Array(shuffled()[0..<count])
    }
    
    public func buildDictionary<Key, Value>(toDict combiner:(Element)->(Key, Value)) -> [Key:Value] {
        var result:[Key:Value] = [:]
        
        for n in self {
            let kv = combiner(n)
            result[kv.0] = kv.1
        }
        
        return result
    }
}

public func ex_stride(from: Double, to: Double, numberOfParts: Double) -> [Double] {
    let step = (to - from) / numberOfParts
    return Array<Double>(stride(from: from, to: to, by: step))
}

public func ex_stride(from: Int, to: Int, numberOfParts: Int) -> [Int] {
    let step = (to - from) / numberOfParts
    return Array<Int>(stride(from: from, to: to, by: step))
}
