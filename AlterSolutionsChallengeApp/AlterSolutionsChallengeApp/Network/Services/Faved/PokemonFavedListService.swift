//
//  PokemonFavedListService.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation
import AlterSolutionsChallengeCore

final class PokemonFavedListService: PokemonFavedListServiceProtocol {
    
    @DependencyInject
    private var favoritesManager: FavoritesManagerProtocol

    func execute() -> [Pokemon] {
        return favoritesManager.favorites
    }

}
