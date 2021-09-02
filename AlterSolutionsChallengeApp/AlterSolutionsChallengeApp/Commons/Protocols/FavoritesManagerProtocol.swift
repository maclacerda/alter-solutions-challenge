//
//  FavoritesManagerProtocol.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 02/09/21.
//

import Foundation

protocol FavoritesManagerProtocol {

    // MARK: - Properties

    var favorites: [Pokemon] { get set }

    // MARK: - Functions

    func faved(_ pokemon: Pokemon)
    func unfaved(_ pokemon: Pokemon)
    func isFaved(_ pokemon: String) -> Bool

}
