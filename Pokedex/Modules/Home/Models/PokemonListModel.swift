//
//  HomeModel.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

// MARK: - PokemonListModel
struct PokemonListModel: Codable {
    let count: Int
    let next: String
    var results: [PokemonItemListModel]
}

// MARK: - PokemonItemListModel
public struct PokemonItemListModel: Codable {
    let name: String
    let url: String
    var detail: PokemonModel?
    
    var id: Int {
        return Int(String(url.split(separator: "/").last ?? "")) ?? .zero
    }
}
