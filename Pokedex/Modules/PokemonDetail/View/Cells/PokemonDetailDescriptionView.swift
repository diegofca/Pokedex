//
//  PokemonDetailDescriptionView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation
import SwiftUI

struct PokemonDetailDescriptionView: View {
    
    var pokemon: PokemonItemListModel
    
    var body: some View {
        VStack {
            Text(Constants.descriptionDetail)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
                .padding(.all, 16)
        }
    }
}

#Preview {
    PokemonDetailDescriptionView(
        pokemon: PokemonItemListModel(name: .empty, url: .empty)
    )
}
