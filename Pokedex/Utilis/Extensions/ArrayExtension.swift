//
//  ArrayExtension.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import Foundation

extension Array {
    func filterDuplicates( includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
}
