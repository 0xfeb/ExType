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
}

public func ex_stride(from: Double, to toValue: Double, numberOfParts: Double) -> [Double] {
    let step = (toValue - from) / numberOfParts
    return [Double](stride(from: from, to: toValue, by: step))
}

public func ex_stride(from: Int, to toValue: Int, numberOfParts: Int) -> [Int] {
    let step = (toValue - from) / numberOfParts
    return [Int](stride(from: from, to: toValue, by: step))
}
