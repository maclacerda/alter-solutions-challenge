//
//  AlterSolutionsChallengeAppDependencies.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 28/08/21.
//

import Foundation
import UIKit
import AlterSolutionsChallengeCore

struct AlterSolutionsChallengeAppDependencies {
    
    // MARK: - Properties
    
    private static let container = DependencyContainer.shared
    
    // MARK: - Public API
    
    static func registerDependencies() {
        do {
            // Commom dependencies
            try registerCommonDependencies()
            
            // Internal dependencies
            try registerInternalDependencies()
        } catch {

        }
    }
    
    // MARK: - Private methods
    
    private static func registerCommonDependencies() throws {
        try container.register(type: ScenesFactoryProtocol.self) {
            return ScenesFactory()
        }
        
        try container.register(type: ImageDownloaderProtocol.self) {
            return KingfisherImageDownloader()
        }
        
        try container.register(type: URLRequestDispatcherProtocol.self) {
            return URLSessionDispatcher()
        }
    }
    
    private static func registerInternalDependencies() throws {
        // Coordinators
        
        try container.register(type: PokemonListCoordinatorProtocol.self) {
            return PokemonListCoordinator()
        }
        
        try container.register(type: PokemonDetailCoordinatorProtocol.self) {
            return PokemonDetailCoordinator()
        }
        
        // UseCases
        
        try container.register(type: ListUseCaseProtocol.self) {
            return ListUseCase()
        }
        
        try container.register(type: DetailUseCaseProtocol.self) {
            return DetailUseCase()
        }
        
        // Services
        
        try container.register(type: PokemonListServiceProtocol.self) {
            return PokemonListService()
        }
    }
    
}
