//
//  AppCoordinator.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    // TODO: add to inject here
    let pokemonListCoordinator: PokemonListCoordinator
    let window: UIWindow
    let rootViewController: UINavigationController
    
    internal var childCoordinators: [String : Coordinator] = [:]
    
    // MARK: - Initializer
    
    init(window: UIWindow) {
        self.window = window
        
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        
        pokemonListCoordinator = PokemonListCoordinator(presenter: rootViewController)
    }

    // MARK: - Flows
    
    func start() {
        window.rootViewController = rootViewController
        pokemonListCoordinator.start()
        
        window.makeKeyAndVisible()
    }

}
