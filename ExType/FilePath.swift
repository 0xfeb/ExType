//
//  FilePath.swift
//  ExType
//
//  Created by 王渊鸥 on 2018/7/24.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public class ExFilePath {
    public var fullPath: String

    public init(_ fullPath: String) {
        self.fullPath = fullPath
    }

    public init?(_ url: URL) {
        if url.absoluteString.starts(with: "http") {
            return nil
        }
        self.fullPath = url.absoluteString
    }

    public enum PathType {
        case file
        case directory
    }

    public var pathType: PathType {
        if let attr = try? FileManager.default.attributesOfItem(atPath: fullPath) {
            if let type = attr[FileAttributeKey.type] as? FileAttributeType {
                if type == .typeRegular {
                    return PathType.file
                }
            }
        }
        return PathType.directory
    }

    public func listSubPaths(recurison: Bool = false) -> [ExFilePath] {
        let filePath = URL(fileURLWithPath: fullPath)
        let opt: FileManager.DirectoryEnumerationOptions =
            recurison ? [.skipsHiddenFiles] : [.skipsHiddenFiles, .skipsSubdirectoryDescendants]
        if let itor = FileManager.default.enumerator(at: filePath,
                                                     includingPropertiesForKeys: nil,
                                                     options: opt,
                                                     errorHandler: nil) {
            return itor.allObjects.compactMap({ (filePath) in
                if let filePath = filePath as? URL {
                    return ExFilePath(filePath.absoluteString)
                }
                return nil
            })
        }
        return []
    }

    public static func createPath(path: String) -> Bool {
        return ((try? FileManager.default.createDirectory(atPath: path,
                                                          withIntermediateDirectories: true,
                                                          attributes: nil)) != nil)
    }

    public static func removePath(path: String) -> Bool {
        return ((try? FileManager.default.removeItem(atPath: path)) != nil)
    }

    public static var home: ExFilePath {
        return ExFilePath(NSHomeDirectory())
    }

    // 文档路径
    public static var documents: ExFilePath {
        return ExFilePath(NSHomeDirectory() + "/Documents")
    }

    // 库路径
    public static var library: ExFilePath {
        return ExFilePath(NSHomeDirectory() + "/Library")
    }

    // Bundle路径
    public static var bundle: ExFilePath {
        let bundle = Bundle.main
        return ExFilePath(bundle.bundlePath)
    }

    public var pathComponents: [String] {
        return (fullPath as NSString).pathComponents
    }

    public var pathExtension: String {
        return (fullPath as NSString).pathExtension
    }

    public var lastPathComponent: String {
        return (fullPath as NSString).lastPathComponent
    }

    public var lastPathMainbody: String {
        let component = lastPathComponent
        if let index = component.lastIndex(of: ".") {
            return String(component[..<index])
        }
        return component
    }

    public func addComponent(string: String) {
        fullPath = (fullPath as NSString).appendingPathComponent(string)
    }

    public func addComponented(string: String) -> String {
        return (fullPath as NSString).appendingPathComponent(string)
    }
}

public func ex_url(_ string: String) -> URL? {
    if string.hasPrefix("http") {
        return URL(string: string)
    } else {
        return URL(fileURLWithPath: string)
    }
}
