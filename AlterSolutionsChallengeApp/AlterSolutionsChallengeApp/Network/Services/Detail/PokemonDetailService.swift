//
//  PokemonDetailService.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation
import AlterSolutionsChallengeCore

final class PokemonDetailService: PokemonDetailServiceProtocol {
    
    // MARK: - Propeties
    
    @DependencyInject
    private var dispatcher: URLRequestDispatcherProtocol
    
    // MARK: - Public API
    
    func execute(with identifier: String, handler: @escaping ((Result<PokemonDetailResponse?, DetailUseCaseError>) -> Void)) {
        let request: PokemonDetailRequest = .detail(pokemon: identifier.lowercased())
        
        _ = dispatcher.execute(request: request, keyPath: nil) { result in
            switch result {
            case .success(let response):
                guard let data = response else {
                    handler(.failure(.error("Response data are corrupted, please try again")))
                    return
                }
                
                do {
                    let pokemon = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
                    handler(.success(pokemon))
                } catch {
                    handler(.failure(.error(error.localizedDescription)))
                }
                
            case .failure(let error):
                handler(.failure(.error(error.localizedDescription)))
            }
        }
    }
    
}
