//
//  ListUseCase.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation
import RxSwift
import AlterSolutionsChallengeCore

struct ListUseCase: ListUseCaseProtocol {
    
    // MARK: - Properties
    
    @DependencyInject
    private var service: PokemonListServiceProtocol
    
    // MARK: - Public API
    
    func execute(offset: Int, limit: Int) -> Observable<Result<[PokemonResponse]?, ListUseCaseError>> {
        return Observable.create { observable in
            service.execute(offset: offset, limit: limit) { result in
                switch result {
                case .success(let pokemons):
                    observable.onNext(.success(pokemons))
                    observable.onCompleted()
                    
                case .failure(let error):
                    observable.onNext(.failure(error))
                    observable.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
}
