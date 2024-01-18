//
//  HomeCollectionCardTypesView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation
import Kingfisher
import SwiftUI

struct HomeCollectionCardTypesView: View {
    
    var detail: PokemonModel
    
    var body: some View {
        VStack(alignment: .listRowSeparatorLeading, spacing: 2) {
            ForEach(detail.types, id: \.slot) { type in
                HStack(alignment: .center) {
                    ZStack(alignment:.center) {
                        Image(type.type.iconType)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 8, height: 8)
                            .scaledToFit()
                    }
                    .frame(width: 12, height: 12)
                    .background { Circle().fill(type.type.colorType) }
                                                                
                    Text(type.type.name.capitalized)
                        .font(.system(size: 10))
                        .padding(.trailing, 4)
                        .foregroundColor(.white.opacity(0.5))

                }
            }
            .padding(.horizontal, 2)
            .padding(.vertical, 2)
            .background( .black.opacity(0.12))
            .cornerRadius(16)
        }
        .padding(.leading, 8)
    }
}

#Preview {
    HomeCollectionCardTypesView(detail: PokemonModel(
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






