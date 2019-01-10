//
//  FilePath.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/24.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension String {
    public var existsDirectory:Bool {
        if let attr = try? FileManager.default.attributesOfItem(atPath: self),
            let type = attr[FileAttributeKey.type] as? FileAttributeType {
            return type == .typeDirectory
        }
        
        return false
    }
    
    public var existsFile:Bool {
        if let attr = try? FileManager.default.attributesOfItem(atPath: self),
            let type = attr[FileAttributeKey.type] as? FileAttributeType {
            return type == .typeRegular
        }
        
        return false
    }
    
    public var subPaths:[String] {
        if let itor = FileManager.default.enumerator(at: URL(fileURLWithPath: self),
                                                     includingPropertiesForKeys: nil,
                                                     options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants],
                                                     errorHandler: nil) {
            return itor.allObjects.compactMap({ (path) in
                return (path as? URL)?.absoluteString
            })
        }
        
        return []
    }
    
    public var subDeepPaths:[String] {
        if let itor = FileManager.default.enumerator(at: URL(fileURLWithPath: self),
                                                     includingPropertiesForKeys: nil,
                                                     options: [.skipsHiddenFiles],
                                                     errorHandler: nil) {
            return itor.allObjects.compactMap({ (path) in
                return (path as? URL)?.absoluteString
            })
        }
        
        return []
    }
    
    public func createDirectory() throws {
        try FileManager.default.createDirectory(atPath: self,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
    }
    
    public func removePath() throws {
        try FileManager.default.removeItem(atPath: self)
    }
    
    public static var homePath: String {
        return NSHomeDirectory()
    }
    
    public static var documentsPath: String {
        return NSHomeDirectory().appendPath("Documents")
    }
    
    public static var libraryPath: String {
        return NSHomeDirectory().appendPath("Library")
    }
    
    public static var bundlePath : String {
        return Bundle.main.bundlePath
    }
    
    public func appendPath(_ path:String) -> String {
        if self.hasSuffix("/") {
            if path.hasPrefix("/") {
                return self + (path[1...] ?? "")
            } else {
                return self + path
            }
        } else {
            if path.hasPrefix("/") {
                return self + path
            } else {
                return self + "/" + path
            }
        }
    }
    
    public var pathComponents:[String] {
        return (self as NSString).pathComponents
    }
    
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    public var lastPathMainbody: String {
        let component = lastPathComponent
        if let index = component.lastIndex(of: ".") {
            return String(component[..<index])
        }
        return component
    }
}
