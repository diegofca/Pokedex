//
//  HomeScreen.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import SwiftUI
import Foundation

struct HomeScreenView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    @EnvironmentObject var coordinator: Coordinator<AppRouter>
    
    var body: some View {
        
        LoadingView(
            isShowing: $viewModel.isShowLoader
        ) {
            NavigationView {
                ZStack {
                    VStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            titleView
                            descriptionView
                            searchBarView
                        }
                        .padding(.horizontal, 16)
                        
                        if viewModel.isFilter {
                            clearFilterView
                        }
                        
                        searchCollectionView
                        HomeCollectionView(
                            items: $viewModel.pokemons
                        ) {
                            self.viewModel.checkForMore($0)
                        }
                    }
                }
            }
        }
        .navigationTitle("Pokémon")
        .navigationBarItems(leading:
                                Image("pokeball_color")
            .imageScale(.large)
            .padding()
        )
        .onAppear {
            viewModel.viewDidLoad()
        }
        .sheet(isPresented: $viewModel.isShowFilter) {
            ForEach(viewModel.filterTypes, id: \.self) { filter in
                Spacer()
                VStack {
                    Text(filter).foregroundStyle(.black)
                }
                .presentationDetents([.fraction(0.1)])
                .onTapGesture {
                    viewModel.showTapFilterView()
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowTypesFilter) {
            ForEach(viewModel.typesList, id: \.rawValue) { type in
                VStack (alignment: .trailing, spacing: 10) {
                    HStack(alignment: .top) {
                        Image(type.icon)
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding(.horizontal, 16)
                        
                        Text(type.rawValue.capitalized).foregroundStyle(.black)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .presentationDetents([.fraction(0.8)])
                    .onTapGesture {
                        viewModel.getPokemonFilterBy(type.rawValue)
                    }
                }
                
            }
        }
    }
}


// MARK: - Modular views
extension HomeScreenView {
    var titleView: some View {
        Text("Pokédex")
            .font(.system(size: 40))
            .padding(.bottom, 8)
            .padding(.top, 32)
    }
    
    var descriptionView: some View {
        Text(Constants.descriptionTitle)
            .font(.system(size: 16))
            .padding(.bottom, 16)
            .frame(height: 60)
    }
    
    var clearFilterView: some View {
        ZStack {
            Text("Clear filter")
                .font(.system(size: 16))
                .padding(.horizontal, 16)
        }
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 1)
        )
        .onTapGesture {
            viewModel.clearFilter()
        }
    }
    
    var searchBarView: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                
                TextField("Search pokémon", text: $viewModel.searchText)
                    .frame(height: 44)
                    .onChange(of: viewModel.searchText) {
                        self.viewModel.getPokemonSearch($0)
                    }
            }
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 1)
            )
            
            Image("filter")
                .frame(width: 60, height: 60)
                .background(.gray.opacity(0.5))
                .foregroundColor(.black)
                .cornerRadius(16)
                .onTapGesture {
                    viewModel.isShowFilter = true
                }
        }
    }
    
    var searchCollectionView: some View {
        ZStack {
            List {
                ForEach(viewModel.resultSearch, id: \.self) { pokemon in
                    HStack(alignment: .firstTextBaseline) {
                        Text("Buscar a \(pokemon.capitalized)")
                            .font(.headline)
                        Spacer()
                    }
                    .background(.white)
                    .onTapGesture {
                        hideKeyboard()
                        viewModel.searchText = .empty
                        viewModel.getPokemonDetailBy(name: pokemon)
                    }
                }
            }
            .scrollDisabled(true)
            .background(.white)
        }
        .frame(height: viewModel.resultSearch.isEmpty ? .zero : 100)
    }
}

#Preview {
    HomeScreenView()
}
