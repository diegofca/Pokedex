//
//  NavigationType.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation
import UIKit

public enum NavigationType {
    case `default`
    case push
    case presentModally
    case presentFullscreen
}

extension NavigationType {
    var presentationStyle: UIModalPresentationStyle {
        switch self {
        case .push, .default:
            return .none
        case .presentModally:
            return .formSheet
        case .presentFullscreen:
            return .fullScreen
        }
    }
}

public enum Transitions {
    public static var fade: CATransition = {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        return transition
    }()
}
