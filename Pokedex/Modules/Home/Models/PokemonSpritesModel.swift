//
//  PokemonSpritesModel.swift
//  Pokedex
//
//  Created by DIEGO on 16/01/24.
//

import Foundation

struct PokemonSpritesModel: Codable {
    let frontDefault: String
    let other: PokemonSpriteOtherModel
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct PokemonSpriteOtherModel: Codable {
    let officialArtwork: PokemonSpriteArtWorkModel
    let showdown: PokemonSpriteShowdownkModel
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
        case showdown
    }
}

struct PokemonSpriteArtWorkModel: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonSpriteShowdownkModel: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
