//
//  EnumCollection.swift
//  blocker
//
//  Created by Rudy Bermudez on 3/22/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import Foundation

/// Protocol for Interable Enums
protocol EnumCollection : Hashable {}

extension EnumCollection {
    
    /// Returns all cases of an Enum
    ///
    /// - Returns: Returns sequence of all cases of an Enum
    static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
}
