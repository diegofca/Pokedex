//
//  PokemonAbilityModel.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation

// MARK: - PokemonAbilityModel
struct PokemonAbilityModel: Codable {
    let slot: Int
    let ability: PokemonAbilityDetailModel
}

// MARK: - PokemonAbilityDetailModel
struct PokemonAbilityDetailModel: Codable {
    let name: String
    let url: String
}
