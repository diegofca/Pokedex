//
//  PokemonDetailAbilitiesView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation
import SwiftUI
import Giffy

struct PokemonDetailAbilitiesView: View {
        
    var pokemon: PokemonItemListModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Abilities")
                .font(.system(size: 16, weight: .semibold))
                .padding(.all, 16)
            
            HStack {
                VStack(alignment: .leading)  {
                    if let types = pokemon.detail?.abilities {
                        ForEach(types, id: \.slot) { type in
                            HStack(alignment: .center) {
                                
                                ZStack(alignment:.center) {
                                    Image(systemName: "bolt.fill")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .scaledToFit()
                                }
                                .frame(width: 24, height: 24)
                                .background { Circle().fill(.white) }
                                                                            
                                Text(type.ability.name.capitalized)
                                    .font(.system(size: 14, weight: .regular))
                                    .padding(.trailing, 4)
                                    .foregroundColor(.gray)

                            }
                            .frame(height: 24)
                            .padding(.horizontal, 16)
                            .cornerRadius(24)
                        }
                    }
                }
                
                Spacer()
                
                if let urlImage = pokemon.detail?.sprites.other.showdown.frontDefault {
                    AsyncGiffy(
                        url: URL(string: urlImage)!
                    ) { giffy in
                        switch giffy {
                        case let .success(view): view
                        default: ProgressView()
                        }
                    }
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

#Preview {
    PokemonDetailAbilitiesView(
        pokemon: PokemonItemListModel(name: .empty, url: .empty)
    )
}
