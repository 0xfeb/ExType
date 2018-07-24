//
//  Dictionary.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/23.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension Dictionary {
    public func map<K, V>(_ converter:(Key, Value) -> (K, V)?) -> [K:V] {
        var result:[K:V] = [:]
        for item in self {
            if let convertedItem = converter(item.key, item.value) {
                result[convertedItem.0] = convertedItem.1
            }
        }
        return result
    }
    
    public var json:String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        return jsonString
    }
}

public func ex_json(text:String) -> [String:Any]? {
    if let data = text.data(using: String.Encoding.utf8) {
        if let dict = try? JSONSerialization.jsonObject(with: data, options: []) {
            return dict as? [String:Any]
        }
    }

    return nil
}
