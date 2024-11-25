//
//  FileMangerHelper.swift
//  Order
//
//  Created by anh on 2024/11/12.
//

import Foundation

class FileHelper {
    private init() {}
    
    static let `default` = FileHelper()
    private let fileManager = FileManager.default
    lazy var cachesDir: URL = {
        return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }()
    
    lazy var documentDir: URL = {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }()
    
    lazy var userDir: URL = {
        let userDirectory = documentDir.child(path: "user")
        do {
            try fileManager.createDirectory(at: userDirectory, withIntermediateDirectories: true)
        } catch {
            print("\(error)")
        }
        return userDirectory
    }()
    
    lazy var userDirInCache: URL = {
        let userDirectory = cachesDir.child(path: "user")
        do {
            try fileManager.createDirectory(at: userDirectory, withIntermediateDirectories: true)
        } catch {
            print(error)
        }
        return userDirectory
    }()
    
    lazy var tmpDir: URL = {
        let tmpDirectory = cachesDir.child(path: "tmp")
        do {
            try fileManager.createDirectory(at: tmpDirectory, withIntermediateDirectories: true)
        } catch {
            print(error)
        }
        return tmpDirectory
    }()
    lazy var errLogDir: URL = {
        let errLogDirectory = cachesDir.child(path: "error_log")
        do {
            try fileManager.createDirectory(at: errLogDirectory, withIntermediateDirectories: true)
        } catch {
            print(error)
        }
        return errLogDirectory
    }()
    
    func homeDirFile(_ companyCd: String, _ userId: String) -> URL {
        let homeDir = userDir.appendingPathComponent("/\(companyCd)/\(userId)")
        do {
            try fileManager.createDirectory(at: homeDir, withIntermediateDirectories: true)
        } catch {
            print(error)
        }
        return homeDir
    }
    
    func delete(url : URL) -> Void {
        do {
            try fileManager.removeItem(at: url)
        } catch {
            print(error)
        }
    }
    
    func createFile(url: URL, content: Data) {
        fileManager.createFile(atPath: url.path, contents: content)
    }
    
    func createFile<T: Encodable>(url: URL, data: T) {
        if let json = try? JSONEncoder().encode(data) {
            fileManager.createFile(atPath: url.path, contents: json)
        }
    }
    
    func read<T: Decodable>(url: URL) -> T? {
        do {
            let jsonData = try String(contentsOf: url, encoding: .utf8)
            let data = try JSONDecoder().decode(T.self, from: jsonData.data(using: .utf8)!)
            return data
        } catch {
            print(error)
            return nil
        }
    }
}

extension FileHelper {
    
    
}
