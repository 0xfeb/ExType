//
//  Helper.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public func setup<T>(_ item: T, _ action: (T) throws -> Void) rethrows -> T {
    try action(item)
    return item
}

public func UUID() -> String {
    let puuid = CFUUIDCreate(nil)
    if let suuid = CFUUIDCreateString(nil, puuid) {
        return "\(suuid)"
    } else {
        let random0 = UInt64.random(in: 0...UInt64.max )
        let random1 = UInt64.random(in: 0...UInt64.max )
        let random2 = UInt64.random(in: 0...UInt64.max )
        return "\(random0)"+"\(random1)"+"\(random2)"
    }
}
