//
//  CacheManager.swift
//  Mezu
//
//  Created by Artem Umanets on 26/05/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

// Exceptions in this class are not handled because they are transparent to the user,
// There is no need to present any error. Ideally errors reported here would be reported to
// some monitoring tool in order to have and idea if something is not working as expected.

class CacheManager {

    private static let delimiter = "-"

    private init() { }

    static func write(data: Data, toUrl url: URL) {
        if let path = CacheManager.path(forUrl: url) {
            do {
                try data.write(to: path)
            } catch (let error) {
                print("error: \(error)")
                // report errors to an external reporting tool
            }
        }
    }

    static func read(fromUrl url: URL) -> Data? {
        if let path = CacheManager.path(forUrl: url) {
            do {
                return try Data(contentsOf: path)
            } catch (let error) {
                print("error: \(error)")
                // report errors to an external reporting tool
            }
        }
        return nil
    }

    static func fileExists(atUrl url: URL) -> Bool {
        let path = CacheManager.path(forUrl: url)
        let fileExist = Foundation.FileManager.default.fileExists(atPath: path?.path ?? "")
        return fileExist
    }

    private static func path(forUrl url: URL) -> URL? {
        let identifier = url.absoluteString
            .replacingOccurrences(of: "/", with: CacheManager.delimiter)
            .replacingOccurrences(of: ":", with: CacheManager.delimiter)
            .replacingOccurrences(of: "@", with: CacheManager.delimiter)
        var path = URL(fileURLWithPath: NSTemporaryDirectory())
        path.appendPathComponent(identifier)
        return path
    }

}
