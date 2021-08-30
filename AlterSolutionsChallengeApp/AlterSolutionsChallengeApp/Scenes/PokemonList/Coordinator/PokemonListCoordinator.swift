//
//  PokemonListCoordinator.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit
import AlterSolutionsChallengeCore

protocol PokemonListCoordinatorProtocol: Coordinator {
    var presenter: BaseNavigationViewController? { get set }
}

final class PokemonListCoordinator: PokemonListCoordinatorProtocol {
    
    // MARK: - Properties
    
    var presenter: BaseNavigationViewController?
    
    @DependencyInject
    private var factory: ScenesFactoryProtocol
    
    @DependencyInject
    private var pokemonDetailCoordinator: PokemonDetailCoordinatorProtocol
    
    // MARK: - Initializer
    
    init() {}
    
    // MARK: - Public API
    
    func start() {
        let viewController = factory.makePokemonList()
        
        viewController.delegate = self
        
        presenter?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - PokemonListViewControllerDelegate

extension PokemonListCoordinator: PokemonListViewControllerDelegate {
    
    func didSelectPokemon(_ pokemon: PokemonDetail) {
        guard let presenter = self.presenter else {
            preconditionFailure("Presenter not be nil.")
        }
        
        pokemonDetailCoordinator.pokemon = pokemon
        pokemonDetailCoordinator.presenter = presenter
        
        pokemonDetailCoordinator.start()
    }
    
}
