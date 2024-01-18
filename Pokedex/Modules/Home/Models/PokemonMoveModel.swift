//
//  PokemonMoveModel.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation

// MARK: - PokemonMoveModel
struct PokemonMoveModel: Codable {
    let move: PokemonMoveDetailModel
}

// MARK: - PokemonMoveDetailModel
struct PokemonMoveDetailModel: Codable {
    let name: String
    let url: String
}
