//
//  Int.swift
//  ExType
//
//  Created by 王渊鸥 on 2019/1/5.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import Foundation

public extension Int {
    //support chinese number in hex text
    private init(hex: Character) {
        switch hex {
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
            let charInt: Int = Int(hex: char)
            if charInt < 16 && charInt >= 0 {
                total = total*16 + charInt
            } else {
                break
            }
        }
        
        self = total
    }
    
    public var hexString:String {
        let fix = "0123456789ABCDEF"
        var result:String = ""
        var left = self
        while left > 0 {
            let c = left % 16
            left = left / 16
            result.insert(fix[c]!, at: result.startIndex)
        }
        return result
    }
    
    public init(nearUp upbound:Double) {
        let c = Int(upbound)
        self = (upbound - Double(c) > 0) ? (c + 1) : c
    }
    
    public init(nearDown downbound:Double) {
        self = Int(downbound)
    }
    
    public init(nearCenter center:Double) {
        let c = Int(center)
        self = (center - Double(c) >= 0.5) ? (c + 1) : c
    }
    
    public init(nearUp upbound:Float) {
        let c = Int(upbound)
        self = (upbound - Float(c) > 0) ? (c + 1) : c
    }
    
    public init(nearDown downbound:Float) {
        self = Int(downbound)
    }
    
    public init(nearCenter center:Float) {
        let c = Int(center)
        self = (center - Float(c) >= 0.5) ? (c + 1) : c
    }
    
    public init(nearUp upbound:CGFloat) {
        let c = Int(upbound)
        self = (upbound - CGFloat(c) > 0) ? (c + 1) : c
    }
    
    public init(nearDown downbound:CGFloat) {
        self = Int(downbound)
    }
    
    public init(nearCenter center:CGFloat) {
        let c = Int(center)
        self = (center - CGFloat(c) >= 0.5) ? (c + 1) : c
    }
    
    init?(skipLetter source:String) {
        let nig = source.hasPrefix("-")
        let cleared = source.filter({ "0123456789".contains($0) })
        guard let value = Int(cleared) else { return nil }
        self = nig ? (0 - value) : value
    }
    
    public var chineseDescription: String {
        if self >= 100_000_000 {
            let number = Float(self) / 100_000_000
            if number == Float(Int(number)) {
                return String(format: "%.0f亿", number)
            } else {
                return String(format: "%.1f亿", number)
            }
        } else if self >= 10_000 {
            let number = Float(self) / 10_000
            if number == Float(Int(number)) {
                return String(format: "%.0f万", number)
            } else {
                return String(format: "%.1f万", number)
            }
        } else if self >= 1_000 {
            let number = Float(self) / 1_000
            return String(format: "%.0f千", number)
        } else {
            return "\(self)"
        }
    }
}

