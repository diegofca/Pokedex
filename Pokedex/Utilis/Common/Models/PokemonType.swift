//
//  PokemonTypeColor.swift
//  Pokedex
//
//  Created by DIEGO on 16/01/24.
//

import Foundation
import SwiftUI

public enum PokemonType: String, CaseIterable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    
    var icon: String {
        return "\(rawValue)_type"
    }
    
    var header: String {
        return "\(rawValue)_header"
    }

    var color: Color {
        switch self {
        case .normal: Color(hex: "919AA2")
        case .fighting: Color(hex: "CE416B")
        case .flying: Color(hex: "89AAE3")
        case .poison: Color(hex: "B567CE")
        case .ground: Color(hex: "D97845")
        case .rock: Color(hex: "C5B78C")
        case .bug: Color(hex: "91C12F")
        case .ghost: Color(hex: "5269AD")
        case .steel: Color(hex: "5A8EA2")
        case .fire: Color(hex: "FF9D55")
        case .water: Color(hex: "5090D6")
        case .grass: Color(hex: "63BC5A")
        case .electric: Color(hex: "F4D23C")
        case .psychic: Color(hex: "FA7179")
        case .ice: Color(hex: "73CEC0")
        case .dragon: Color(hex: "0B6DC3")
        case .dark: Color(hex: "5A5465")
        case .fairy: Color(hex: "EC8FE6")
        }
    }
}
