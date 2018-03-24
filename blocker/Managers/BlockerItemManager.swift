//
//  BlockItemManager.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/20/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation

/// Handles Blocking of `BlockerDataSource`
class BlockerItemManager {
    
    
    // MARK: - Properties
    
    /// Instance of `BlockerFileManager`
    fileprivate let fileManager: BlockerFileManager
    
    
    // MARK: - Initializers
    
    /// Initialize with generic `BlockerFileManager`
    init() {
        self.fileManager = BlockerFileManager()
    }
    
    
    /// Init with custom instance of `BlockerFileManager`
    ///
    /// - Parameter manager: instance of `BlockerFileManager`
    init(fileManager manager: BlockerFileManager) {
        self.fileManager = manager
    }
    
    
    // MARK: - Functions
    
    /// Toggles blocking a `BlockerDataSource`
    ///
    /// - Parameters:
    ///   - item: `BlockerDataSource` to add / remove from Blocking
    ///   - enable: enable/disable the blockItem
    /// - Returns: Boolean that denotes a successful toggle
    @discardableResult
    func toggle<T: BlockerDataSource>(item: T, enable: Bool) -> Bool {
        return enable ? fileManager.add(item) : fileManager.remove(item)
    }
    
    
    /// Returns a list of enabled `BlockerDataSource` in BlockerFile
    ///
    /// - Parameter type: type that conforms to `BlockerDataSourceCollection`
    /// - Returns: List of enabled `BlockerItemDataSource` in BlockerFile
    func getActiveItems<T: BlockerDataSourceCollection>(type: T.Type) -> [T] {
        return fileManager.getEnabledItems(of: type)
    }
    
}
