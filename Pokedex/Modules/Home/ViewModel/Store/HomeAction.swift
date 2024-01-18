//
//  HomeAction.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

enum HomeAction {
    case getPokemonsWith(offset: Int)
    case getPokemonsSuccess(_ result: PokemonListModel)
    case getPokemonsFailure(_ error: Error)
    case getPokemonsDetailWith(name: String)
    case getPokemonsDetailSuccess(_ result: PokemonModel)
    case getPokemonsDetailFailure(_ error: Error)
}
