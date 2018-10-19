//
//  UIType.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/10/19.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import UIKit

let apartText = "%"

public extension UIFont {
    public convenience init?(text:String) {
        guard let (name, size) = text.apart2(apartText) else { return nil }
        guard let textSize = Float(size) else { return nil }
        
        self.init(name: name, size: CGFloat(textSize))
    }
    
    public var text:String {
        return "\(fontName)\(apartText)\(pointSize)"
    }
}

public extension CGRect {
    public init?(text:String) {
        guard let (x, y, w, h) = text.apart4(apartText) else { return nil }
        guard let left = Double(x), let top = Double(y),
            let width = Double(w), let height = Double(h) else { return nil }
        
        self.init(x: left, y: top, width: width, height: height)
    }
    
    public var text:String {
        return "\(minX)\(apartText)\(minY)\(apartText)\(width)\(apartText)\(height)"
    }
}

public extension CGPoint {
    public init?(text:String) {
        guard let (x, y) = text.apart2(apartText) else { return nil }
        guard let left = Double(x), let top = Double(y) else { return nil }
        
        self.init(x: left, y: top)
    }
    
    public var text:String {
        return "\(x)\(apartText)\(y)"
    }
}

public extension CGSize {
    public init?(text:String) {
        guard let (w, h) = text.apart2(apartText) else { return nil }
        guard let width = Double(w), let height = Double(h) else { return nil }
        
        self.init(width: width, height: height)
    }
    
    public var text:String {
        return "\(width)\(apartText)\(height)"
    }
}

public extension CGAffineTransform {
    public init?(text:String) {
        guard let (_a, _b, _c, _d, _tx, _ty) = text.apart6(apartText) else { return nil }
        guard let a = Double(_a), let b = Double(_b), let c = Double(_c), let d = Double(_d),
            let tx = Double(_tx), let ty = Double(_ty) else { return nil }
        
        self.init(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c),
                  d: CGFloat(d), tx: CGFloat(tx), ty: CGFloat(ty))
    }
    
    public var text:String {
        return "\(a)\(apartText)\(b)\(apartText)\(c)\(apartText)\(d)\(apartText)\(tx)\(apartText)\(ty)"
    }
}
