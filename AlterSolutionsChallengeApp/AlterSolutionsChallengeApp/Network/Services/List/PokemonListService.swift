//
//  PokemonListService.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation
import AlterSolutionsChallengeCore

final class PokemonListService: PokemonListServiceProtocol {
    
    // MARK: - Propeties
    
    @DependencyInject
    private var dispatcher: URLRequestDispatcherProtocol
    
    // MARK: - Public API
    
    func execute(offset: Int, limit: Int, handler: @escaping ((Result<[PokemonResponse]?, ListUseCaseError>) -> Void)) {
        let request: PokemonListRequest = .pokemonList(offset: offset, limit: limit)
        
        _ = dispatcher.execute(request: request, keyPath: "results") { result in
            switch result {
            case .success(let response):
                guard let data = response else {
                    handler(.failure(.error("Response data are corrupted, please try again")))
                    return
                }
                
                do {
                    let pokemons = try JSONDecoder().decode([PokemonResponse].self, from: data)
                    handler(.success(pokemons))
                } catch {
                    handler(.failure(.error(error.localizedDescription)))
                }
                
            case .failure(let error):
                handler(.failure(.error(error.localizedDescription)))
            }
        }
    }
    
}
