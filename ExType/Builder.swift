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

    //support chinese number in hex text
    private init(hexChar: Character) {
        switch hexChar {
        case "0", "０": self = 0
        case "1", "１": self = 1
        case "2", "２": self = 2
        case "3", "３": self = 3
        case "4", "４": self = 4
        case "5", "５": self = 5
        case "6", "６": self = 6
        case "7", "７": self = 7
        case "8", "８": self = 8
        case "9", "９": self = 9
        case "a", "A", "ａ", "Ａ": self = 10
        case "b", "B", "ｂ", "Ｂ": self = 11
        case "c", "C", "ｃ", "Ｃ": self = 12
        case "d", "D", "ｄ", "Ｄ": self = 13
        case "e", "E", "ｅ", "Ｅ": self = 14
        case "f", "F", "ｆ", "Ｆ": self = 15
        default: self = 0xFFFFFFF
        }
    }

    public init(hex: String) {
        var total: Int = 0
        for char in hex {
            let charInt: Int = Int(hexChar: char)
            if charInt < 16 && charInt >= 0 {
                total = total*16 + charInt
            } else {
                break
            }
        }

        self = total
    }
    
    public init(nearUp upbound:Double) {
        let c = Int(upbound)
        self = (upbound - Double(c) > 0) ? (c + 1) : c
    }
    
    init?(skipLetter source:String) {
        let nig = source.hasPrefix("-")
        let cleared = source.filter({ "0123456789".contains($0) })
        guard let value = Int(cleared) else { return nil }
        self = nig ? (0 - value) : value
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
