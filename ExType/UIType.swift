//
//  UIType.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/10/19.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import UIKit

fileprivate let apartText = "%"

extension UIFont {
    convenience init?(text:String) {
        guard let (name, size) = text.split(apartText, limit: 2).tuple2 else { return nil }
        guard let textSize = Float(size) else { return nil }
        
        self.init(name: name, size: CGFloat(textSize))
    }
    
    var text:String {
        return "\(fontName)\(apartText)\(pointSize)"
    }
}

extension CGRect {
    init?(text:String) {
        guard let (x, y, w, h) = text.split(apartText, limit: 4).tuple4 else { return nil }
        guard let left = Double(x), let top = Double(y),
            let width = Double(w), let height = Double(h) else { return nil }
        
        self.init(x: left, y: top, width: width, height: height)
    }
    
    var text:String {
        return "\(minX)\(apartText)\(minY)\(apartText)\(width)\(apartText)\(height)"
    }
}

extension CGPoint {
    init?(text:String) {
        guard let (x, y) = text.split(apartText, limit: 2).tuple2 else { return nil }
        guard let left = Double(x), let top = Double(y) else { return nil }
        
        self.init(x: left, y: top)
    }
    
    var text:String {
        return "\(x)\(apartText)\(y)"
    }
}

extension CGSize {
    init?(text:String) {
        guard let (w, h) = text.split(apartText, limit: 2).tuple2 else { return nil }
        guard let width = Double(w), let height = Double(h) else { return nil }
        
        self.init(width: width, height: height)
    }
    
    var text:String {
        return "\(width)\(apartText)\(height)"
    }
}

extension CGAffineTransform {
    init?(text:String) {
        guard let (_a, _b, _c, _d, _tx, _ty) = text.split(apartText, limit: 6).tuple6 else { return nil }
        guard let a = Double(_a), let b = Double(_b), let c = Double(_c), let d = Double(_d),
            let tx = Double(_tx), let ty = Double(_ty) else { return nil }
        
        self.init(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c),
                  d: CGFloat(d), tx: CGFloat(tx), ty: CGFloat(ty))
    }
    
    var text:String {
        return "\(a)\(apartText)\(b)\(apartText)\(c)\(apartText)\(d)\(apartText)\(tx)\(apartText)\(ty)"
    }
}
