//
//  Router.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import SwiftUI

public protocol Router {
    associatedtype DefinitionView: View
    
    var transition: NavigationType { get }
    
    @ViewBuilder
    func view() -> DefinitionView
}
