//
//  PokemonDetailMovesView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation
import SwiftUI

struct PokemonDetailMovesView: View {
        
    var pokemon: PokemonItemListModel
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            
            Text("Moves")
                .font(.system(size: 16, weight: .semibold))
                .padding(.all, 16)
            
            if let moves = pokemon.detail?.moves {
                ForEach(moves, id: \.move.name) { move in
                    HStack(alignment: .center) {
                        
                        ZStack(alignment:.center) {
                            Image("hit")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .scaledToFit()
                        }
                        .frame(width: 24, height: 24)
                        .background { Circle().fill(.white) }
                                                                    
                        Text(move.move.name.capitalized)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)

                    }
                    .frame(height: 24)
                    .padding(.horizontal, 16)
                    .cornerRadius(24)
                    
                }
            }
        }
    }
}

#Preview {
    PokemonDetailMovesView(
        pokemon: PokemonItemListModel(name: .empty, url: .empty)
    )
}
