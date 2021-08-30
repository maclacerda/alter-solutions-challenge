//
//  PokemonListViewControllerDelegate.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import Foundation

protocol PokemonListViewControllerDelegate: AnyObject {
    
    func didSelectPokemon(_ pokemon: PokemonDetail)
    
}
