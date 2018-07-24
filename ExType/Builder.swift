//
//  Builder.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension Int {
    public init(string: String) {
        self = (string as NSString).integerValue
    }
    
    private init(hexChar: Character) {
        switch hexChar {
        case "0": self = 0
        case "1": self = 1
        case "2": self = 2
        case "3": self = 3
        case "4": self = 4
        case "5": self = 5
        case "6": self = 6
        case "7": self = 7
        case "8": self = 8
        case "9": self = 9
        case "a", "A": self = 10
        case "b", "B": self = 11
        case "c", "C": self = 12
        case "d", "D": self = 13
        case "e", "E": self = 14
        case "f", "F": self = 15
        default: self = 0xFFFFFFF
        }
    }
    
    public init(hex: String) {
        var total:Int = 0
        for char in hex {
            let c:Int = Int(hexChar: char)
            if c < 16 && c >= 0 {
                total = total*16 + c
            } else {
                break
            }
        }
        
        self = total
    }
}

public extension Float {
    public init(string: String) {
        self = (string as NSString).floatValue
    }
}

public extension Double {
    public init(string: String) {
        self = (string as NSString).doubleValue
    }
}
