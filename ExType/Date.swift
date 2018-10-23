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
        return formatter.string(from: self)
    }
    
    public init?(ISOString:String) {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: ISOString) {
            self = date
        } else {
            return nil
        }
    }
}
