//
//  PokemonListRequest.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation
import AlterSolutionsChallengeCore

enum PokemonListRequest: URLRequestProtocol {
    
    case pokemonList(offset: Int, limit: Int)
    
    var baseURL: URL {
        return Environment.baseURL
    }
    
    var path: String {
        return "pokemon"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: URLRequestParameters? {
        switch self {
        case .pokemonList(let offset, let limit):
            return .url([
                "offset": offset,
                "limit": limit
            ])
        }
    }
    
    var headers: [String: Any]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
}
