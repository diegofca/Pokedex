//
//  DataBaseAgent.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import Foundation

public enum Directory {
    case documents
    case caches
}

public protocol DataBaseAgent: AnyObject {
    func add(_ model: DecodableModel)
    func retrieve<T: Decodable>(_ name: String?, type: T.Type) -> T?
}
