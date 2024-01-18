//
//  AppDependecies.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation
import Resolver

public enum AppDependencies {
    public static func bindComponents() {
        
        // MARK: - Network
        Resolver.register { NetworkProvider() as NetworkProviderProtocol }

        // MARK: - Use Cases
        Resolver.register { GetPokemonListHomeUseCase() as GetPokemonListUseCaseProtocol }
        Resolver.register { GetPokemonDetailUseCase() as GetPokemonDetailUseCaseProtocol }

        Resolver.register { DataBaseProvider(strategy: .documents) as DataBaseProviderProtocol }.scope(.cached)

        // MARK: - Storage
        //Resolver.register(name: .userDefaults) { StorageProvider(strategy: .userDefaults) as StorageProviderProtocol }.scope(.application)
        
        // MARK: - Stores
        Resolver.register {
            Store<HomeState, HomeAction>(
                state: .neverLoaded,
                reducer: HomeReducer.reduce(state:action:),
                middlewares: [
                    HomeMiddleware.executeGetPokemonList(),
                    HomeMiddleware.executeGetPokemonDetail()
                ]
            )
        }.scope(.cached)
    }
}

public extension Resolver.Name {
    static let userDefaults = Self("UserDefaults")
    static let coreData = Self("UserDefaults")
}
