//
//  ApiResponse.swift
//  Pokedex
//
//  Created by DIEGO on 15/01/24.
//

import Foundation
import Resolver

public typealias HttpHeaders = [String: String]
public typealias HttpQueryParams = [String: String]

public protocol BaseUrl {
    var baseUrl: URL { get }
}

public struct ApiResponse<T: Decodable> {
    public let response: T
    public let code: Int
}

public protocol AppRoutable: BaseUrl {
    var path: String { get }
    var queryParams: HttpQueryParams { get }
    var headers: HttpHeaders { get }
    var method: HttpMethod { get }
}

public extension AppRoutable {
    
    var queryParams: HttpQueryParams { [:] }
    
    var baseUrl: URL {
        guard let url = URL(string: "https://pokeapi.co/api/v2") else { fatalError("Base url could not be configured.")
        }
        return url
    }

    var headers: HttpHeaders {
        return [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json; charset=utf-8"
        ]
    }
    
    func buildUrl() -> URL {
        guard let url = URL(
            string: baseUrl.appendingPathComponent(path).description
        ) else {
            return URL(fileURLWithPath: .empty)
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryParams.compactMap {
            return URLQueryItem(
                name: $0.key, value: $0.value
            )
        }
       return urlComponents?.url ?? URL(fileURLWithPath: .empty)
    }

    func buildRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: buildUrl())
        urlRequest.httpMethod = method.rawValue

        headers.forEach { header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        return urlRequest
    }
}
