//
//  BlockerFileManager.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/21/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation
import SafariServices

/// Models JSON
fileprivate typealias JSON = [String:Any]

// Models JSON Array
fileprivate typealias BlockerList = [JSON]

/// Manages any FileHandling of JSON BlockerList
public class BlockerFileManager {
    
    // MARK: - Properties
    
    /// The `URL` of the file where the blockerList will be saved
    public var blockerListURL: URL?
    
    /// Default instance of FileManager
    let fileManager = FileManager.default
    
    
    // MARK: - Initializer
    
    /// Default Initializer sets `blockerListURL`
    init() {
        var baseURL: URL?
        
        if let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.webblocker") {
            baseURL = url
        }
        
        if let baseURL = baseURL {
            blockerListURL = baseURL.appendingPathComponent("CustomBlockerList.json", isDirectory: false)
        }
        
    }
    
    
    // MARK: - Read / Write JSON
    
    /// Read blockerList URL and Convert to JSONArray
    ///
    /// - Returns: JSON Array
    fileprivate func readBlockerList() -> BlockerList {
        
        guard
            let blockerListURL = blockerListURL,
            let data = try? Data(contentsOf: blockerListURL),
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let blockerList = json as? [[String:Any]]
        else { return [] }
        
        return blockerList
    }
    
    
    /// Write `BlockerList` to File & Reload Content Blocker
    ///
    /// - Parameter blockerList: JSON Array to write to file
    /// - Returns: Bool that denotes whether the blockerList was successfully written to file
    fileprivate func write(_ blockerList: BlockerList) -> Bool {
        
        guard
            let url = blockerListURL,
            let jsonData = try? JSONSerialization.data(withJSONObject: blockerList, options: []),
            let _ = try? jsonData.write(to: url)
        else {
            return false
        }
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: "io.rudybermudez.blocker.extension", completionHandler: nil)
        return true
    }
    
    // MARK: - Create / Delete Blocker File
    
    
    /// Create Empty Blocker File
    ///
    /// - Returns: Bool that denotes whether the blockerList was successfully created
    @discardableResult
    public func createEmptyBlockerFile() -> Bool {
        guard let url = blockerListURL, fileManager.fileExists(atPath: url.path) == false else { return false }
        
        return write(readBlockerList())
    }
    
    /// Delete BlockerFile.
    ///
    /// - Returns: true if file was removed or does not exist, false otherwise
    @discardableResult
    public func deleteBlockerFile() -> Bool {
        guard let url = blockerListURL, fileManager.fileExists(atPath: url.path) == true else { return true }
        do {
            try fileManager.removeItem(at: url)
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - Helper Functions
    
    
    /// Add `BlockerDataSource` to `BlockerList`
    ///
    /// - Parameter item: `BlockerDataSource` to add to BlockerList
    /// - Returns: Bool that denotes whether the `BlockerItemDataSource` was successfully added to the `BlockerList`
    @discardableResult
    func add<T: BlockerDataSource>(_ item: T) -> Bool {
        
        var blockerList = readBlockerList()
        
        guard index(of: item, in: blockerList) == nil else { return false }
        
        let json: [String:Any] = [
            "action": [ "type": "block" ],
            "trigger": [ "url-filter": item.urlFilter ]
        ]
        
        // BlockerList is initalized with an empty dictionary, it is important to overwrite it
        if blockerList.isEmpty {
            blockerList = [json]
        } else {
            blockerList.append(json)
        }
        return write(blockerList)
    }
    
    
    /// Remove `BlockerDataSource` from `BlockerList`
    ///
    /// - Parameter item: `BlockerDataSource` to remove from BlockerList
    /// - Returns: Bool that denotes whether the `BlockerDataSource` was successfully removed from the `Blockerlist`
    @discardableResult
    func remove<T: BlockerDataSource>(_ item: T) -> Bool {
        
        var blockerList = readBlockerList()
        
        guard let index = index(of: item, in: blockerList) else { return false }
        
        blockerList.remove(at: index)
        return write(blockerList)
    }
    
    
    /// Retrieve the index of a `BlockerDataSource` in a `BlockerList`
    /// Note: This checks the urlFilter Property of the `BlockerDataSource`
    /// - Parameters:
    ///   - blockItem: `BlockerDataSource` to check for
    ///   - blockerList: A JSON Array [[String: Any]]
    /// - Returns: `Int` that denotes the index of a `BlockerDataSource` in the `BlockerList`; `nil` if not found
    fileprivate func index<T: BlockerDataSource>(of blockItem: T, in blockerList: BlockerList) -> Int? {
        
        for (index, item) in blockerList.enumerated() {
            guard
                let trigger = item["trigger"] as? [String:String],
                let urlTrigger = trigger["url-filter"]
            else { break }

            if urlTrigger == blockItem.urlFilter { return index }
        }
        
        return nil
    }
    
    
    /// Return a list of actively blocked `BlockerDataSource` in BlockerList
    ///
    /// - Parameter type: `BlockerDataSourceCollection` to check for
    /// - Returns: A List of active `BlockerDataSource`
    func getEnabledItems<T: BlockerDataSourceCollection>(of type: T.Type) -> [T] {
        return type.cases().flatMap { index(of: $0, in: readBlockerList()) != nil ?  $0 : nil }
    }
    
    // MARK: - Debugging Functions
    
    /// Pretty Print the JSON BlockerList
    func debugPrint() {
        print("\n\n=============================\nBegin Debug Print\n")
        let jsonObject = try? JSONSerialization.data(withJSONObject: readBlockerList(), options: .prettyPrinted)
        
        if let jsonString = String(data: jsonObject!, encoding: .utf8) {
            print(jsonString)
        }
        print("\n=============================\nEnd Debug Print\n\n")
    }
    
}
