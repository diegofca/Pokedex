//
//  HomeCollectionCardTitleView.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import Foundation
import SwiftUI

struct HomeCollectionCardTitleView: View {

    @Binding var item: PokemonItemListModel

    var body: some View {
        HStack {
            Text($item.wrappedValue.name.capitalized)
                .font(.system(size: 14))
                .foregroundColor(.white)
                
            Spacer()
            Text(
                "#\(String(format: "%03d", $item.wrappedValue.detail?.id ?? 0))"
            )
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.5))
        }
        .padding(.horizontal, 8)
    }
}
