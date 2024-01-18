//
//  HomeReducer.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

enum HomeReducer {
    static func reduce(state: inout HomeState, action: HomeAction) {
        switch action {
        case .getPokemonsWith:
            state = .loadingListInfo
        
        case let .getPokemonsSuccess(info):
            state = .loadedListInfo(info)
            
        case let .getPokemonsFailure(error):
            state = .withError(error)
            
        case let .getPokemonsDetailWith(name):
            state = .loadingDetailWith(name)
            
        case let .getPokemonsDetailSuccess(info):
            state = .loadedDetailInfo(info)
            
        case let .getPokemonsDetailFailure(error):
            state = .withError(error)
        
        }
    }
}
