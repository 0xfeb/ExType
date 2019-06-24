//
//  Comparable.swift
//  ExType
//
//  Created by 王渊鸥 on 2019/1/5.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import Foundation

extension Comparable {
    mutating func limit(_ min: Self, _ max: Self) {
        if self < min { self = min }
        if self > max { self = max }
    }
    
    func limited(_ min: Self, _ max: Self) -> Self {
        if self < min { return min }
        if self > max { return max }
        return self
    }
}



