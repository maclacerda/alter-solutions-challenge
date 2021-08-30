//
//  ListUseCase.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation
import RxSwift

struct ListUseCase: ListUseCaseProtocol {
    
    func execute(offset: Int, limit: Int) -> Observable<Result<[PokemonResponse]?, ListUseCaseError>> {
        return Observable.create { observable in
            DispatchQueue.main.async {
                observable.onNext(.success([PokemonResponse]()))
            }
            
            return Disposables.create()
        }
    }
    
}
