//
//  PokemonDetailCoordinator.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit

final class PokemonDetailCoordinator: Coordinator {
    
    // ADD @Inject
    private var factory: ScenesFactoryProtocol {
        return ScenesFactory()
    }
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    private let pokemon: Pokemon
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, pokemon: Pokemon) {
        self.presenter = presenter
        self.pokemon = pokemon
    }
    
    func start() {
        let viewController = factory.makePokemonDetail(with: pokemon)
        viewController.delegate = self
        
        presenter.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - PokemonDetailViewControllerDelegate

extension PokemonDetailCoordinator: PokemonDetailViewControllerDelegate {
    
}
