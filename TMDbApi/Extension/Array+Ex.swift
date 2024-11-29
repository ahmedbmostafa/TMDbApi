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
        return filter { seen.insert($0[keyPath: keyPath]).inserted }
    }
}
