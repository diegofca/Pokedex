//
//  HomeCollectionCardImageView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import SwiftUI
import Kingfisher

struct HomeCollectionCardImageView: View {
    
    var detail: PokemonModel
    
    var body: some View {
        ZStack(alignment: .center) {
            Image("pokeball_grey")
                .resizable()
                .opacity(0.5)
                .frame(width: 100, height: 100)
                .offset(x: 25, y: 25)
                .scaledToFit()
            
            KFImage.url(URL(string: detail.sprites.frontDefault))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 1.25)
                .resizable()
                .scaledToFit()
                .offset(x: 5, y: -5)
                .frame(width: 80, height: 80)
        }
    }
}

#Preview {
    HomeCollectionCardImageView(detail: PokemonModel(
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
