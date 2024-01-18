//
//  PokemonDetailTypeSectionView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation
import SwiftUI

struct PokemonDetailTypeSectionView: View {
        
    var pokemon: PokemonItemListModel
    
    var body: some View {
        HStack {
            if let types = pokemon.detail?.types {
                ForEach(types, id: \.slot) { type in
                    HStack(alignment: .center) {
                        
                        ZStack(alignment:.center) {
                            Image(type.type.iconType)
                                .resizable()
                                .frame(width: 15, height: 15)
                                .scaledToFit()
                        }
                        .frame(width: 24, height: 24)
                        .background { Circle().fill(.white) }
                                                                    
                        Text(type.type.name.capitalized)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 4)
                            .foregroundColor(.black.opacity(0.8))

                    }
                    .frame(height: 36)
                    .padding(.horizontal, 16)
                    .background { type.type.colorType }
                    .cornerRadius(24)
                    
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    PokemonDetailTypeSectionView(
        pokemon: PokemonItemListModel(name: .empty, url: .empty)
    )
}
