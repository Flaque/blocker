//
//  BlockItemManager.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/20/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation

class BlockItemManager {
    
    let listManager: BlockerListManager
    
    init(listManager blockerListManager: BlockerListManager) {
        self.listManager = blockerListManager
    }
    
    func toggle(item: BlockItem, enable: Bool) -> Bool {
        
        return enable ? listManager.add(blockItem: item) : listManager.remove(blockItem: item)
    }
}
