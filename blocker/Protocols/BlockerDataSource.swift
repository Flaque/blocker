//
//  BlockerDataSource.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/22/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation

typealias EnumBlockerDataSource = BlockerDataSource & EnumCollection

/// Models the Data Source of an Item to Block
protocol BlockerDataSource {
    
    /// The base URL to filter out
    var urlFilter: String { get }
    
    /// Category of the DataSource
    var category: BlockerItemCategory { get }
}

