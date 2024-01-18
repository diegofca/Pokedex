//
//  HomeUseCase.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation
import Combine
import Resolver

// MARK: - Home Use Cases

final class GetPokemonListHomeUseCase: GetPokemonListUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute(offset: Int) -> AnyPublisher<ApiResponse<PokemonListModel>, AppError.Api> {
        network.agent.run(
            HomeApiRouter(route: .getPokemonList(offset: offset))
        )
    }
}

final class GetPokemonDetailUseCase: GetPokemonDetailUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute(name: String) -> AnyPublisher<ApiResponse<PokemonModel>, AppError.Api> {
        network.agent.run(
            HomeApiRouter(route: .getPokemonDetail(name: name))
        )
    }
}
