//
//  FilePath.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/24.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension String {
    var existsDirectory:Bool {
        if let attr = try? FileManager.default.attributesOfItem(atPath: self),
            let type = attr[FileAttributeKey.type] as? FileAttributeType {
            return type == .typeDirectory
        }
        
        return false
    }
    
    var existsFile:Bool {
        if let attr = try? FileManager.default.attributesOfItem(atPath: self),
            let type = attr[FileAttributeKey.type] as? FileAttributeType {
            return type == .typeRegular
        }
        
        return false
    }
    
    var subPaths:[String] {
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
    
    var subDeepPaths:[String] {
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
    
    func createDirectory() throws {
        try FileManager.default.createDirectory(atPath: self,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
    }
    
    func removePath() throws {
        try FileManager.default.removeItem(atPath: self)
    }
    
    static var homePath: String {
        return NSHomeDirectory()
    }
    
    static var documentsPath: String {
        return NSHomeDirectory().appendPath("Documents")
    }
    
    static var libraryPath: String {
        return NSHomeDirectory().appendPath("Library")
    }
    
    static var bundlePath : String {
        return Bundle.main.bundlePath
    }
    
    func appendPath(_ path:String) -> String {
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
    
    var pathComponents:[String] {
        return (self as NSString).pathComponents
    }
    
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    var lastPathMainbody: String {
        let component = lastPathComponent
        if let index = component.lastIndex(of: ".") {
            return String(component[..<index])
        }
        return component
    }
}
