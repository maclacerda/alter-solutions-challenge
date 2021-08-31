//
//  PokemonDetailRequest.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation
import AlterSolutionsChallengeCore

enum PokemonDetailRequest: URLRequestProtocol {
    
    case detail(pokemon: String)
    
    var baseURL: URL {
        return Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .detail(let pokemonIdentifier):
            return String(format: "pokemon/%@", pokemonIdentifier)
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: URLRequestParameters? {
        return nil
    }
    
    var headers: [String: Any]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
}
