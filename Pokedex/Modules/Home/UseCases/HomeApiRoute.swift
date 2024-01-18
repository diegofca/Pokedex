//
//  HomeApiRoute.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

enum HomeApiRoute {
    case getPokemonList(offset: Int)
    case getPokemonDetail(name: String)
}

protocol HomeApiRouteable: AppRoutable {
    var route: HomeApiRoute { get set }
}

extension HomeApiRouteable {
    
    var queryParams: HttpQueryParams {
        switch route {
        case let .getPokemonList(offset):
            return [
                "offset": String(offset),
                "limit": String(14)
            ]
        default:
            return [:]
        }
    }
    
    var path: String {
        switch route {
        case .getPokemonList:
            return "/pokemon"
        case let .getPokemonDetail(name):
            return "/pokemon/\(name)"
        }
    }
    
    var method: HttpMethod {
        switch route {
        case .getPokemonList, .getPokemonDetail:
            return .get
        }
    }
}

struct HomeApiRouter: HomeApiRouteable {
    var route: HomeApiRoute
}
