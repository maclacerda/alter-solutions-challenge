//
//  DetailUseCase.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation
import RxSwift
import AlterSolutionsChallengeCore

struct DetailUseCase: DetailUseCaseProtocol {
    
    // MARK: - Properties
    
    @DependencyInject
    private var service: PokemonDetailServiceProtocol
    
    // MARK: - Public API
    
    func execute(with identifier: String) -> Observable<Result<PokemonDetailResponse?, DetailUseCaseError>> {
        return Observable.create { observable in
            service.execute(with: identifier) { result in
                switch result {
                case .success(let pokemon):
                    observable.onNext(.success(pokemon))
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
