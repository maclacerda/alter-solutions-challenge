//
//  Pokemon.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import Foundation

struct Pokemon {
    
    let name: String
    let photo: String
    
    var isFaved: Bool
    
    // MARK: - Helpers

    func buildAnalyticsParams() -> [String: Any] {
        return [
            PokemonEventKeys.name.rawValue: self.name,
            PokemonEventKeys.photo.rawValue: self.photo,
            PokemonEventKeys.faved.rawValue: self.isFaved ? "yes" : "no"
        ]
    }

}
