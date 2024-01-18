//
//  AppRouter.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import SwiftUI

enum AppRouter: Router {
    case home
    case pokemonDetail(PokemonItemListModel)
    
    public var transition: NavigationType {
        switch self {
        case .home, .pokemonDetail:
            return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .home:
            HomeScreenView()
        case let .pokemonDetail(pokemon):
            PokemonDetailScreenView(pokemon: pokemon)
        }
    }
}

