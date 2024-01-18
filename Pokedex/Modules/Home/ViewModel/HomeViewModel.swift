//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Combine
import SwiftUI
import Resolver

class HomeViewModel: ObservableObject {
    
    @Published var offset: Int = .zero
    @Published var searchText: String = .empty
    @Published var resultSearch: [String] = []
    @Published var isShowFilter: Bool = false
    @Published var isShowTypesFilter: Bool = false
    @Published var pendingChangePage: Bool = false
    @Published var isFilter: Bool = false
    @Published var isShowLoader: Bool = true

    @Injected private var store: Store<HomeState, HomeAction>
    @Injected var dbProvider: DataBaseProviderProtocol

    @Published private var pokemonsSafe: [PokemonItemListModel] = []
    @Published var pokemons: [PokemonItemListModel] = []
    @Published var pokemonsFilter: [PokemonItemListModel] = []
    
    var filterTypes: [String] = ["Filter by Type"]
    var typesList: [PokemonType] = PokemonType.allCases
    
    
    private let concurrentQueue = DispatchQueue(label: "FlashThread", attributes: .concurrent)
    private var cancellables = Set<AnyCancellable>()

    deinit {
        cancellables.removeAll()
    }
    
    func viewDidLoad() {
        if pokemonsSafe.isEmpty {
            suscribeStore()
            initLoadPokemonList()
        }
    }
}


// MARK: - Filters methods
extension HomeViewModel {
    // Search pokemos by: { searchTerm }
    func getPokemonSearch(_ searchTerm: String) {
        pokemonsFilter = pokemonsSafe.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
        pokemons = searchTerm.isEmpty ? pokemonsSafe : pokemonsFilter.isEmpty ? [] : pokemonsFilter
        resultSearch = pokemonsFilter.isEmpty && !searchTerm.isEmpty ? [searchTerm] : []
    }
    
    func showTapFilterView() {
        isShowFilter = false
        isShowTypesFilter = true
    }
    
    func getPokemonFilterBy(_ type: String) {
        isShowTypesFilter = false
        isFilter = true
        pokemonsFilter = pokemonsSafe.filter {
            $0.detail?.types.contains(
                where: { $0.type.name == type } ) ?? false
        }
        pokemons = pokemonsFilter.isEmpty ? [] : pokemonsFilter
    }
    
    func clearFilter() {
        isFilter = false
        pokemons = pokemonsSafe
    }
}


extension HomeViewModel {
    func getPokemonListDispatch(withNewOffset: Int = .zero) {
       //DispatchQueue.main.async {
            self.offset = withNewOffset
            self.store.dispatch(.getPokemonsWith(offset: withNewOffset))
       // }
    }
    
    func initLoadPokemonList() {
        if let pokemons = dbProvider.agent.retrieve(Constants.homeListKey, type: [PokemonItemListModel].self) {
            let pokemonsSorted = pokemons.sorted(by: {$0.id < $1.id})
            self.pokemonsSafe = pokemonsSorted
            self.pokemons = pokemonsSorted
            self.isShowLoader = false
            self.getPokemonDetails()
            
        } else {
            getPokemonListDispatch()
        }
    }
    
    func getPokemonDetailBy(name: String) {
        store.dispatch(.getPokemonsDetailWith(name: name.lowercased()))
    }
    
    func getPokemonDetails() {
        let dbAgent = dbProvider.agent
        
        pokemons.forEach { pokemon in
            guard pokemon.detail == nil else { return }
            let nameFile = "\(pokemon.name).json"
            
            if let pokemonDetail = dbAgent.retrieve(nameFile, type: PokemonModel.self) {
                DispatchQueue.main.async {
                    if let idx = self.pokemons.firstIndex(where: { $0.name == pokemonDetail.name }) {
                        self.pokemons[idx].detail = pokemonDetail
                    }
                }
            } else {
                
                guard !self.isFilter || self.searchText.isEmpty else { return }
                
               concurrentQueue.async {
                   DispatchQueue.main.async {
                        self.getPokemonDetailBy(name: pokemon.name)
                   }
               }
            
            }
        }
    }
    
    func checkForMore(_ item: PokemonItemListModel, pendingChange: Bool = false) {
        guard searchText.isEmpty && !isFilter else { return }
        
        let thresholdIndex = pokemons.index(pokemons.endIndex, offsetBy: -1)
        if pendingChange || pokemons.lastIndex(where: { $0.name == item.name }) == thresholdIndex {
            
            pendingChangePage = pokemons.last?.detail == nil
            if !pendingChangePage {
                getPokemonListDispatch(withNewOffset: pokemons.count)
            }
        }
    }
}


extension HomeViewModel {
    
    // MARK: - Suscribers
    func suscribeStore() {
        
        store.$state.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case let .loadedListInfo(info):
                let pokemonsSorted = (self.pokemons + info.results)
                    .filterDuplicates(includeElement: {$0.id == $1.id })
                
                self.pokemons = pokemonsSorted
                self.pokemonsSafe = pokemonsSorted
                self.dbProvider.agent.add(.pokemonList(self.pokemons))
                self.getPokemonDetails()
                self.isShowLoader = false
                
            case let .loadedDetailInfo(info):
                if let idx = self.pokemons.firstIndex(where: { $0.name == info.name }) {
                    dbProvider.agent.add(.pokemon(info))
                    self.pokemons[idx].detail = info
                
                } else {
                    self.getnewPokemonDetail(info)
                }
                
            default:
                break
            }
        }.store(in: &cancellables)
    }
    
    private func getnewPokemonDetail(_ info: PokemonModel) {
        let newPokemon = PokemonItemListModel(
            name: info.name,
            url: "https://pokeapi.co/api/v2/pokemon/\(info.id)/",
            detail: info
        )
        
        // Add new detail to Pokemon
        dbProvider.agent.add(.pokemon(info))
        
        // Add new list to Pokemons
        pokemonsSafe.append(newPokemon)
        pokemons = [newPokemon]
        getPokemonSearch(newPokemon.name)
    }
}
