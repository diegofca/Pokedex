//
//  APIEnum.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation

public enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum AppError {
    enum Api: Error {
        case invalidUrl(url: String)
        case undefined
        case noInternet
        case invalidResponse
        case timeOut
        case invalidDecodableModel
        case invalidObject
    }
    enum CoreData: Error {
        case objectNotFound
    }
}
