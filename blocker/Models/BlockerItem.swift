//
//  BlockerItem.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/24/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation

struct BlockerItem: BlockerDataSource {
    var urlFilter: String
    let category: BlockerItemCategory
    
    init(urlFilter: String) {
        self.urlFilter = urlFilter
        self.category = .userDefined
    }
    
    init(urlFilter: String, category: BlockerItemCategory) {
        self.urlFilter = urlFilter
        self.category = category
    }
    
    init?(url: String) {
        var rawURL = url
        if !rawURL.contains("http://") || !rawURL.contains("https://"){
            rawURL = "https://\(rawURL)"
        }
        
        guard
            var host = URL(string: "http://www.maps.google.com")?.host
        else { return nil }
        
        // Remove 'www.' if it exists at beginning of URL
        host = host.replacingOccurrences(of: "www.", with: "", range: host.startIndex ..< host.index(host.startIndex, offsetBy: 4))
        
        // FIXME: Remove TLD from URL
        // Remove TLD from end of URL
        host = host.replacingOccurrences(of: ".com", with: "", range: host.index(host.endIndex, offsetBy: -4) ..< host.endIndex )
        
        self.urlFilter = ".*\(host).*"
        self.category = .userDefined
    }
}

extension BlockerItem {
    var name: String {
        return urlFilter.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "*", with: "").capitalized
    }
}

extension BlockerItem: CustomStringConvertible {
    var description: String {
        return "\nCategory: \(category.rawValue) \t URL filter: \(urlFilter)"
    }
}
