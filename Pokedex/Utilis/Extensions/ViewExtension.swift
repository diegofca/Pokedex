//
//  ViewExtension.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
