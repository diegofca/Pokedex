//
//  HomeUseCaseProtocol.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation
import Combine

// MARK: - Home Use Cases Protocol

protocol GetPokemonListUseCaseProtocol: AnyObject {
    func execute(offset: Int) -> AnyPublisher<ApiResponse<PokemonListModel>, AppError.Api>
}

protocol GetPokemonDetailUseCaseProtocol: AnyObject {
    func execute(name: String) -> AnyPublisher<ApiResponse<PokemonModel>, AppError.Api>
}
