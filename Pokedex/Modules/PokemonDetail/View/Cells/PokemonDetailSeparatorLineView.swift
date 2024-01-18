//
//  PokemonDetailSeparatorLineView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import SwiftUI

struct PokemonDetailSeparatorLineView: View {
            
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {}
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(.gray.opacity(0.2))
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    PokemonDetailSeparatorLineView()
}
