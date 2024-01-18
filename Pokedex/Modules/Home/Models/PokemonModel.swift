//
//  PokemonModel.swift
//  Pokedex
//
//  Created by DIEGO on 16/01/24.
//

import Foundation
import SwiftUI

// MARK: - PokemonModel
public struct PokemonModel: Codable {
    var baseExperience: Int
    var height: Int
    var id: Int
    var name: String
    var order: Int
    var types: [PokemonTypeModel]
    var sprites: PokemonSpritesModel
    var abilities: [PokemonAbilityModel]
    var moves: [PokemonMoveModel]

    var colorType: Color? {
        return types.first?.type.colorType
    }
    
    var iconHeader: String? {
        return types.first?.type.iconHeader
    }
    
    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height
        case id
        case name
        case order
        case types
        case sprites
        case abilities
        case moves
    }
    
}
