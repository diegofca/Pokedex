//
//  PokemonDetailHeaderView.swift
//  Pokedex
//
//  Created by DIEGO on 18/01/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct PokemonDetailHeaderView: View {
        
    var pokemon: PokemonItemListModel
    
    var body: some View {
        VStack(spacing: .zero) {
            GeometryReader { proxy in
                ZStack(alignment: .bottom) {
                    if let headerType = pokemon.detail?.iconHeader {
                        Image(headerType)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: 160)
                    }
                    
                    if let urlImage = pokemon.detail?.sprites.other.officialArtwork.frontDefault {
                       KFImage.url(URL(string: urlImage))
                            .loadDiskFileSynchronously()
                            .cacheMemoryOnly()
                            .fade(duration: 0.5)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .offset(x: .zero, y: 130)
                    }
                }
                .ignoresSafeArea()
                .frame(width: proxy.size.width, height: 100)
            }
        }
        .padding(.bottom, 265)
    }
}

#Preview {
    PokemonDetailHeaderView(
        pokemon: PokemonItemListModel(name: .empty, url: .empty)
    )
}
