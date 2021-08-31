//
//  PokemonDetailCoordinator.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit
import AlterSolutionsChallengeCore

protocol PokemonDetailCoordinatorProtocol: Coordinator {
    var presenter: BaseNavigationViewController? { get set }
    var pokemon: PokemonDetail? { get set }
}

final class PokemonDetailCoordinator: PokemonDetailCoordinatorProtocol {
    
    // MARK: - Properties
    
    var presenter: BaseNavigationViewController?
    var pokemon: PokemonDetail?
    
    @DependencyInject
    private var factory: ScenesFactoryProtocol
    
    // MARK: - Initializer
    
    init() {}
    
    func start() {
        guard let pokemon = self.pokemon else {
            preconditionFailure("Pokemon not be nil.")
        }
        
        let viewController = factory.makePokemonDetail(with: pokemon)
        
        viewController.delegate = self
        
        presenter?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - PokemonDetailViewControllerDelegate

extension PokemonDetailCoordinator: PokemonDetailViewControllerDelegate {

    func didNotifyFavedUnFavedPokemon() {
        NotificationCenter.default.post(name: .pokemonDataModified, object: nil, userInfo: nil)
    }

}
