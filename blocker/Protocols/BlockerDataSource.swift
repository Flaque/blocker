//
//  BlockerDataSource.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/22/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation


/// BlockerDataSource that can be put into a collection
typealias BlockerDataSourceCollection = BlockerDataSource & EnumCollection


/// Models the Data Source of an Item to Block
protocol BlockerDataSource {
    
    /// The base URL to filter out
    var urlFilter: String { get }
    
}
