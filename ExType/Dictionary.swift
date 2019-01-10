//
//  Dictionary.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/23.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension Dictionary {
    public var jsonString: String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        return jsonString
    }
}
