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
        let viewModel = PokemonListViewModel()
        
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
        
        return viewController
    }
    
    func makePokemonDetail(with pokemon: PokemonDetail) -> PokemonDetailViewController {
        let viewController = PokemonDetailViewController()
        let viewModel = PokemonDetailViewModel(with: pokemon)
        
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
        
        return viewController
    }
    
}
