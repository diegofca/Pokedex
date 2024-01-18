//
//  PokemonDetailScreen.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import Foundation
import SwiftUI

struct PokemonDetailScreenView: View {
    
    @EnvironmentObject var coordinator: Coordinator<AppRouter>
    
    var pokemon: PokemonItemListModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    PokemonDetailHeaderView(pokemon: pokemon)
                    PokemonDetailTitleView(pokemon: pokemon)
                    PokemonDetailTypeSectionView(pokemon: pokemon)
                    PokemonDetailSeparatorLineView()
                    PokemonDetailDescriptionView(pokemon: pokemon)
                    PokemonDetailSeparatorLineView()
                    PokemonDetailAbilitiesView(pokemon: pokemon)
                    PokemonDetailSeparatorLineView()
                    PokemonDetailMovesView(pokemon: pokemon)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Image(systemName: "chevron.backward")
                .frame(width: 40, height: 40)
                .background(pokemon.detail?.colorType?.opacity(0.5))
                .foregroundColor(.white)
                .cornerRadius(30)
                .onTapGesture { coordinator.pop() }
        )
    }
}

#Preview {
    PokemonDetailScreenView(
        pokemon: PokemonItemListModel(name: .empty, url: .empty)
    )
}
