//
//  BlockItem.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/20/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation


/// Social Network Sources
enum Social: BlockerDataSource, EnumCollection {

    // MARK: - Sources
    case facebook
    case fourchan
    case gplus
    case imgur
    case instagram
    case myspace
    case pinterest
    case reddit
    case tumblr
    case twitter
    case youtube
    
    // MARK: - Properties
    
    /// The base URL to filter out
    var urlFilter: String {
        switch self {
        case .fourchan:
            return ".*4chan.*"
        case .facebook:
            return ".*facebook.*"
        // We will also need to block `.*fbcdn.*`
        case .gplus:
            return "*.plus.google.*"
        case .imgur:
            return ".*imgur.*"
        case .instagram:
            return ".*instagram.*"
        case .myspace:
            return ".*myspace.*"
        case .pinterest:
            return ".*pinterest.*"
        case .reddit:
            return ".*reddit.*"
        case .tumblr:
            return ".*tumblr.*"
        case .twitter:
            return ".*twitter.*"
        case .youtube:
            return ".*youtube.*"
        }
    }
    
}


/// News Sources
enum News: BlockerDataSource, EnumCollection {
    
    // MARK: - Sources
    case abc
    case aljazeera
    case bloomberg
    case bbc
    case cbs
    case cnn
    case fox
    case msnbc
    case nbcnews
    case npr
    case nytimes
    case pbs
    case theDailyShow
    case glennbeck
    case theguardian
    case huffpost
    case newyorker
    case rachelmaddow
    case rushlimbaugh
    case hannity
    case wsj
    case usatoday
    case washingtonpost
    
    // MARK: - Properties
    var urlFilter: String {
        switch self {
        case .abc:
            return ".*abc.*"
        case .aljazeera:
            return ".*aljazeera.*"
        case .bloomberg:
            return ".*bloomberg.*"
        case .bbc:
            return ".*bbc.*"
        case .cbs:
            return ".*cbs.*"
        case .cnn:
            return ".*cnn.*"
        case .fox:
            return".*fox.*"
        case .msnbc:
            return ".*msnbc.*"
        case .nbcnews:
            return ".*nbcnews.*"
        case .npr:
            return ".*npr.*"
        case .nytimes:
            return ".*nytimes.*"
        case .pbs:
            return ".*pbs.*"
        case .theDailyShow:
            return ".*the-daily-show.*"
        case .glennbeck:
            return ".*glennbeck.*"
        case .theguardian:
            return ".*theguardian.*"
        case .huffpost:
            return ".*huffpost.*"
        case .newyorker:
            return ".*newyorker.*"
        case .rachelmaddow:
            return ".*rachelmaddow.*"
        case .rushlimbaugh:
            return ".*rushlimbaugh.*"
        case .hannity:
            return ".*hannity.*"
        case .wsj:
            return ".*wsj.*"
        case .usatoday:
            return ".*usatoday.*"
        case .washingtonpost:
            return ".*washingtonpost.*"
        }
    }
}


