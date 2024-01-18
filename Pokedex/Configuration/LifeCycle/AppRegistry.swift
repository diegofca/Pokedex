//
//  AppRegistry.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

class PokedexRegistry: NSObject, AppLifecycleProtocol {
    override init() {
        super.init()
        AppDependencies.bindComponents()
    }
}

struct AppRegistry {
    var registry: [AppLifecycleProtocol]
    
    init() {
        self.registry = [PokedexRegistry()]
    }
    
    func getRegistry() -> [AppLifecycleProtocol] { registry }
}
