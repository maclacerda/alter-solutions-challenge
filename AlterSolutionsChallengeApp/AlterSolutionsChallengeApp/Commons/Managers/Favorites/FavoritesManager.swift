//
//  FavoritesManager.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 02/09/21.
//

import Foundation

final class FavoritesManager: FavoritesManagerProtocol {

    // MARK: Singleton

    static let shared = FavoritesManager()
    
    // MARK: - Properties

    internal var favorites = [Pokemon]()
    
    // MARK: - Initialization

    private init() {}

    // MARK: - Helpers

    func faved(_ pokemon: Pokemon) {
        let name = pokemon.name

        guard favorites.filter({ $0.name == name }).first == nil else {
            return
        }

        favorites.append(pokemon)
    }
    
    func unfaved(_ pokemon: Pokemon) {
        let name = pokemon.name

        guard let index = favorites.firstIndex(where: { $0.name == name }) else {
            return
        }

        favorites.remove(at: index)
    }

    func isFaved(_ pokemon: String) -> Bool {
        guard favorites.filter({ $0.name == pokemon }).first != nil else {
            return false
        }

        return true
    }

}
