//
//  BlockerListManager.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/21/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation

fileprivate typealias JSON = [String:Any]
fileprivate typealias BlockerList = [JSON]

/// Manages any FileHandling of JSON BlockerList
public class BlockerListManager {
    
    // MARK: - Properties
    
    /// The `URL` of the file where the blockerList will be saved
    public var blockerListURL: URL?
    
    /// Default instance of FileManager
    let fileManager = FileManager.default
    
    
    // MARK: - Init
    /// Default Initializer sets `blockerListURL`
    init() {
        var baseURL: URL?
        
        if let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
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
    
    
    /// Write `BlockerList` to File
    ///
    /// - Parameter blockerList: JSON Array to write to file
    /// - Returns: Bool that denotes whether the blockerList was successfully written to file
    fileprivate func write(_ blockerList: BlockerList) -> Bool {
        
        guard
            let url = blockerListURL,
            let jsonData = try? JSONSerialization.data(withJSONObject: blockerList, options: .prettyPrinted),
            let _ = try? jsonData.write(to: url)
        else {
            return false
        }
       
        return true
    }
    
    /// Delete BlockerFile.
    ///
    /// - Returns: true if file was removed or does not exist, false otherwise
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
    
    
    /// Add `BlockItem` to `blockerList`
    ///
    /// - Parameters:
    ///   - blockItem: `BlockItem` to add
    ///   - blockerList: `BlockerList` to add to
    /// - Returns: Bool that denotes whether the `BlockItem` was successfully added to the `BlockerList`
    @discardableResult
    func add(blockItem: BlockItem) -> Bool {
        
        var blockerList = readBlockerList()
        
        guard index(of: blockItem, in: blockerList) == nil else { return false }
        
        let json: JSON = [
            "action": [ "type": "block" ],
            "trigger": [ "url-filter": blockItem.urlFilter ]
        ]
        
        // BlockerList is initalized with an empty dictionary, it is important to overwrite it
        if blockerList.isEmpty {
            blockerList = [json]
        } else {
            blockerList.append(json)
        }
        return write(blockerList)
    }
    
    
    /// Remove BlockItem from blockerList
    ///
    /// - Parameters:
    ///   - blockItem: `BlockItem` to remove
    ///   - blockerList: `BlockerList` to remove from
    /// - Returns: Bool that denotes whether the `BlockItem` was successfully removed from the `Blockerlist`
    @discardableResult
    func remove(blockItem: BlockItem) -> Bool {
        
        var blockerList = readBlockerList()
        
        guard let index = index(of: blockItem, in: blockerList) else { return false }
        
        blockerList.remove(at: index)
        return write(blockerList)
    }
    
    
    /// Retrieve the index of a `BlockItem` in a `BlockerList`
    ///
    /// - Parameters:
    ///   - blockerList: A JSON Array [[String: Any]]
    ///   - blockItem: A `BlockItem` to check for
    /// - Returns: Optional `Int` that denotes the index of a `BlockItem` in the `BlockerList`
    fileprivate func index(of blockItem: BlockItem, in blockerList: BlockerList) -> Int? {
        
        for (index, item) in blockerList.enumerated() {
            guard
                let trigger = item["trigger"] as? [String:String],
                let urlTrigger = trigger["url-filter"]
            else { break }

            if urlTrigger == blockItem.urlFilter { return index }
        }
        
        return nil
    }
    
    func debugPrint() {
        print("\n\n=============================\nBegin Debug Print\n")
        print(readBlockerList())
        print("\n=============================\nEnd Debug Print\n\n")
    }
    
}
