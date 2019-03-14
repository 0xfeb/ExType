//
//  Date.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/10/23.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension Date {
    public var ISOString:String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = Calendar.current.timeZone
        return formatter.string(from: self)
    }
    
    public init?(ISOString:String) {
        func timeOptions(_ ISOString:String) -> ISO8601DateFormatter.Options {
            var options = ISO8601DateFormatter.Options()
            
            if ISOString.contains("-") {
                options.insert(.withDashSeparatorInDate)
                options.insert(.withFullDate)
            }
            
            if ISOString.contains(":") {
                options.insert(.withColonSeparatorInTime)
                options.insert(.withFullDate)
            }
            
            if ISOString.contains(" ") {
                options.insert(.withSpaceBetweenDateAndTime)
            }
            
            return options
        }
        
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = Calendar.current.timeZone
        formatter.formatOptions = timeOptions(ISOString)
        if let date = formatter.date(from: ISOString) {
            self = date
        } else {
            return nil
        }
    }
}
