//
//  NetworkProviderProtocol.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

protocol NetworkProviderProtocol {
    var agent: NetworkAgentProtocol { get }
}

public final class NetworkProvider: NetworkProviderProtocol {
    var agent: NetworkAgentProtocol
    init() { agent = NetworkAgent() }
}
