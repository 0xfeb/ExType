//
//  URL.swift
//  ExType
//
//  Created by 王渊鸥 on 2019/1/5.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import Foundation

public extension URL {
    public init?(auto string:String) {
        if let url = string.hasPrefix("http") ? URL(string: string) : URL(fileURLWithPath: string) {
            self = url
        } else {
            return nil 
        }
    }
}
