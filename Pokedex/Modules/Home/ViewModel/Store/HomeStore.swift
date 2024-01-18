//
//  HomeStore.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

enum HomeState {
    case neverLoaded
    case loadingListInfo
    case loadedListInfo(PokemonListModel)
    case loadingDetailWith(String)
    case loadedDetailInfo(PokemonModel)
    case withError(Error)
}
