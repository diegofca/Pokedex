//
//  HomeMiddleware.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

import Combine
import Resolver
import CoreData

enum HomeMiddleware {
    @Injected private static var getPokemonListUseCase: GetPokemonListUseCaseProtocol
    @Injected private static var getPokemonDetailUseCase: GetPokemonDetailUseCaseProtocol
    @Injected private static var coreData: DataBaseAgent
    
    static func executeGetPokemonList() -> Middleware<HomeState, HomeAction> {
        { _, action in
            guard case let .getPokemonsWith(offset) = action else { return Empty().eraseToAnyPublisher() }

            return getPokemonListUseCase
                .execute(offset: offset)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .map { .getPokemonsSuccess($0.response) }
                .catch { log(error: $0, dispatch: .getPokemonsFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    static func executeGetPokemonDetail() -> Middleware<HomeState, HomeAction> {
        { _, action in
            guard case let .getPokemonsDetailWith(name) = action else { return Empty().eraseToAnyPublisher() }
            
            return getPokemonDetailUseCase
                .execute(name: name)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .map { .getPokemonsDetailSuccess($0.response) }
                .catch { log(error: $0, dispatch: .getPokemonsDetailFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension HomeMiddleware {
    private static func log(error: Error, dispatch: HomeAction) -> AnyPublisher<HomeAction, Never> {
        debugPrint("[\(String(describing: self))] Causal: \(error)")
        return Just(dispatch).setFailureType(to: Never.self).eraseToAnyPublisher()
    }
}
