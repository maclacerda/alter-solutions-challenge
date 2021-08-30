//
//  AppCoordinator.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit
import AlterSolutionsChallengeCore

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    @DependencyInject
    var pokemonListCoordinator: PokemonListCoordinatorProtocol
    
    let window: UIWindow
    let rootViewController: BaseNavigationViewController
    
    internal var childCoordinators: [String: Coordinator] = [:]
    
    // MARK: - Initializer
    
    init(window: UIWindow) {
        self.window = window
        
        rootViewController = BaseNavigationViewController()
        rootViewController.navigationBar.prefersLargeTitles = true
        
        self.window.rootViewController = rootViewController
    }

    // MARK: - Flows
    
    func start() {
        pokemonListCoordinator.presenter = rootViewController
        pokemonListCoordinator.start()
        
        window.makeKeyAndVisible()
    }

}
