//
//  DetailUseCase.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation
import RxSwift

public struct DetailUseCase: DetailUseCaseProtocol {
    
    func execute(with identifier: String) -> Observable<Result<PokemonDetailResponse?, DetailUseCaseError>> {
        return Observable.create { observable in
            DispatchQueue.main.async {
                observable.onNext(.success(nil))
            }
            
            return Disposables.create()
        }
    }
    
}
