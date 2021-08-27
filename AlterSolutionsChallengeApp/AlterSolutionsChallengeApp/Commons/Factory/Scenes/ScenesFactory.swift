//
//  ScenesFactory.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit

final class ScenesFactory: ScenesFactoryProtocol {
    
    // MARK: - Factory methods
    
    func makePokemonList() -> PokemonListViewController {
        let viewController = PokemonListViewController()
        
        return viewController
    }
    
    func makePokemonDetail(with pokemon: Pokemon) -> PokemonDetailViewController {
        let viewController = PokemonDetailViewController()
        
        return viewController
    }
    
}
