//
//  ScenesFactoryProtocol.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit

protocol ScenesFactoryProtocol: AnyObject {
    
    func makePokemonList() -> PokemonListViewController
    func makePokemonDetail(with pokemon: PokemonDetail) -> PokemonDetailViewController
    
}
