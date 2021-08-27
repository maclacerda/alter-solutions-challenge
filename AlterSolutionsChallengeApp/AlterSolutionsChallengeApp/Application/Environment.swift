//
//  Environment.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import Foundation

class Environment {
    
    // MARK: Enums
    enum EnvironmentType: String {
        case dev
    }
    
    // MARK: - Singleton
    static let shared = Environment()
    
    // MARK: - Properties
    var baseURL: String!
    var spritesURL: String!
    var runtimeEnvironment: EnvironmentType?
    
    // MARK: - Computed Properties
    var currentRuntimeEnvironment: EnvironmentType? {
        if let runtimeEnvironment = runtimeEnvironment {
            return runtimeEnvironment
        }
        return .dev
    }
    
    // MARK: - Lifecycle
    required init() {
        setup()
    }
    
    // MARK: - Configuration
    func setup() {
        guard let runtimeEnvironment = currentRuntimeEnvironment else { return }
        switch runtimeEnvironment {
        case .dev:
            self.baseURL = "https://pokeapi.co/api/v2/"
            self.spritesURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/"
        }
    }
    
}
