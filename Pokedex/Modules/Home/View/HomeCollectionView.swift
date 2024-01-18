//
//  CollectionView.swift
//  Pokedex
//
//  Created by DIEGO on 16/01/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct HomeCollectionView: View {

    @EnvironmentObject var coordinator: Coordinator<AppRouter>
    @Binding var items: [PokemonItemListModel]
    
    var onLoadMore: ((PokemonItemListModel) -> Void)?

    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVGrid( columns: columns, spacing: 12) {
                    ForEach($items, id: \.name) { item in
                        VStack(spacing: .zero) {
                            HomeCollectionCardTitleView(item: item)
                                .padding(.top, 24)
                            
                            if let detail = item.wrappedValue.detail {
                                HomeCollectionDetailCardView(detail: detail)
                            } else {
                                Spacer()
                            }
                        }
                        .onTapGesture {
                            coordinator.show(.pokemonDetail(item.wrappedValue))
                        }
                        .background(
                            (item.wrappedValue.detail?.colorType ?? .gray)
                        )
                        .onAppear { onLoadMore?(item.wrappedValue) }
                        .frame(width: proxy.size.width / 2.3 , height: proxy.size.height / 4.5)
                        .cornerRadius(16)
                        .shadow(
                            color: (item.wrappedValue.detail?.colorType ?? .gray).opacity(0.5),
                            radius: 12, x: 0, y: 0
                        )
                        
                    }
                }
                .padding(16)
                
                if items.isEmpty {
                    Text("No se encontraron resultdos de tu busqueda")
                        .font(.system(size: 14))
                }
                
            }
        }
        .ignoresSafeArea(.keyboard)

    }
}
