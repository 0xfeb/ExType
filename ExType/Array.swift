//
//  Array.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension Array {
    public func removed(at position:Array.Index) throws -> Array {
        if position < self.startIndex || position >= self.endIndex {
            throw CollectionError.invalidIndex
        }
        
        var result = self
        result.remove(at: position)
        
        return result
    }
    
    public func removed(at positions:[Array.Index]) throws -> Array {
        var result = self
        for position in positions.sorted(by: >) {
            if position < self.startIndex || position >= self.endIndex {
                throw CollectionError.invalidIndex
            }
            
            result.remove(at: position)
        }
        
        return result
    }
}

public extension Array where Element : Equatable {
    public func removed(in list:[Element]) -> [Element] {
        return self.filter({ !list.contains($0) })
    }
    
    public func removed(notIn list:[Element]) -> [Element] {
        return self.filter({ list.contains($0) })
    }
}



