//
//  PokemonListCoordinator.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit

final class PokemonListCoordinator: Coordinator {
    
    // MARK: - Properties
    
    // ADD @Inject
    private var factory: ScenesFactoryProtocol {
        return ScenesFactory()
    }
    
    private let presenter: UINavigationController
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let viewController = factory.makePokemonList()
        viewController.delegate = self
        
        presenter.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - PokemonListViewControllerDelegate

extension PokemonListCoordinator: PokemonListViewControllerDelegate {
    
    func didSelectPokemon(_ pokemon: Pokemon) {
        let coordinator = PokemonDetailCoordinator(presenter: presenter, pokemon: pokemon)
        coordinator.start()
    }
    
}
