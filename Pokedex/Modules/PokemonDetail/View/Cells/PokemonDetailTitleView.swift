//
//  PokemonDetailTitleView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation
import SwiftUI

struct PokemonDetailTitleView: View {
        
    var pokemon: PokemonItemListModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pokemon.name.capitalized)
                .font(.system(size: 42, weight: .bold))
            
            Text("N°\(String(format: "%03d", pokemon.id))")
                .font(.system(size: 16))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}

#Preview {
    PokemonDetailTitleView(
        pokemon: PokemonItemListModel(name: .empty, url: .empty)
    )
}
