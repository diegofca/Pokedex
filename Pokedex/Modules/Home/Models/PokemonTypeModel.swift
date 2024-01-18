//
//  PokemonTypeModel.swift
//  Pokedex
//
//  Created by DIEGO on 16/01/24.
//

import Foundation
import SwiftUI

// MARK: - PokemonTypeModel
struct PokemonTypeModel: Codable {
    let slot: Int
    let type: PokemonTypeDetailModel
}

// MARK: - PokemonTypeDetailModel
struct PokemonTypeDetailModel: Codable {
    let name: String
    let url: String
    
    var colorType: Color {
        return PokemonType(rawValue: name)?.color ?? .white
    }
    
    var iconType: String {
        return PokemonType(rawValue: name)?.icon ?? ""
    }
    
    var iconHeader: String {
        return PokemonType(rawValue: name)?.header ?? ""
    }
}
