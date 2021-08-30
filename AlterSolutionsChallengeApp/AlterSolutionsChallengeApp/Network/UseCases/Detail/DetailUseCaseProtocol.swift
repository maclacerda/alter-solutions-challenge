//
//  DetailUseCaseProtocol.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import RxSwift

enum DetailUseCaseError: Error {
    case error(String)
}

protocol DetailUseCaseProtocol {
    
    func execute(with identifier: String) -> Observable<Result<PokemonDetailResponse?, DetailUseCaseError>>
    
}
