//
//  Delay.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import Foundation

extension DispatchQueue {
    func delay(_ delay: Double, closure:@escaping ()->()) {
        self.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}


