//
//  Array+Ex.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation

extension Array {
    func uniqued<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        var duplicates = [T]()
        return filter { element in
            let value = element[keyPath: keyPath]
            if !seen.insert(value).inserted {
                duplicates.append(value)
                print("Duplicate ID found: \(value)")
                return false
            }
            return true
        }
    }
}
