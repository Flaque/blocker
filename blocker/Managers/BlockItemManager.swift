//
//  BlockItemManager.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/20/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation

class BlockItemManager {
    
    fileprivate let listManager: BlockerListManager
    
    init() {
        self.listManager = BlockerListManager()
    }
    
    init(listManager blockerListManager: BlockerListManager) {
        self.listManager = blockerListManager
    }
    
    
    /// Toggles blocking a `BlockItem`
    ///
    /// - Parameters:
    ///   - item: `BlockItem` to add / remove from Blocking
    ///   - enable: enable/disable the blockItem
    /// - Returns: Boolean that denotes a successful toggle
    func toggle<T: BlockItem>(item: T, enable: Bool) -> Bool {
        return enable ? listManager.add(blockItem: item) : listManager.remove(blockItem: item)
    }
    
    func activeItems<T: BlockItem & EnumCollection>(type: T.Type) -> [T] {
        return listManager.getEnabledItems(blockItem: type)
    }
    
}
