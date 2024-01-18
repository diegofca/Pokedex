//
//  DataBaseProvider.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import Foundation

public protocol DataBaseProviderProtocol {
    var agent: DataBaseAgent { get }
}

public enum DatabaseStrategy {
    case documents
}

public final class DataBaseProvider: DataBaseProviderProtocol {
    public let agent: DataBaseAgent

    public init(strategy: DatabaseStrategy) {
        switch strategy {
        case .documents:
            agent = DocumentsAgent()
        }
    }
}
