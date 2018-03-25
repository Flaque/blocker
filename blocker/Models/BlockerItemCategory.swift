//
//  BlockerItemCategory.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/24/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation


/// Models the Category of `BlockerItem`
///
/// - social: Social Network BlockerItem
/// - news: News BlockerItem
/// - userDefined: User Defined BlockerItem
enum BlockerItemCategory: String {
    
    case social = "Social"
    case news = "News"
    case userDefined = "User Defined"
    
}
