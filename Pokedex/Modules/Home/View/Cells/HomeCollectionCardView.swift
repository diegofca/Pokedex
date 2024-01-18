//
//  HomeCollectionCardView.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import Foundation
import Kingfisher
import SwiftUI

struct HomeCollectionDetailCardView: View {
    
    var detail: PokemonModel
    
    var body: some View {
        HStack(spacing: .zero) {
            HomeCollectionCardTypesView(detail: detail)
            HomeCollectionCardImageView(detail: detail)
        }
    }
    
}

#Preview {
    HomeCollectionDetailCardView(detail: PokemonModel(
        baseExperience: .zero,
        height: .zero,
        id: .zero,
        name: .empty,
        order: .zero,
        types: [],
        sprites: PokemonSpritesModel(
            frontDefault: .empty,
            other: PokemonSpriteOtherModel(
                officialArtwork: PokemonSpriteArtWorkModel(
                    frontDefault: .empty
                ),
                showdown: PokemonSpriteShowdownkModel(
                    frontDefault: .empty
                )
            )
        ),
        abilities: [],
        moves: []
    ) )
}
