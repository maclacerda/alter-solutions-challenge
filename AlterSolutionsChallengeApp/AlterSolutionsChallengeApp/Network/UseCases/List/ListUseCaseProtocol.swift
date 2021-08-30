//
//  ListUseCaseProtocol.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import RxSwift

enum ListUseCaseError: Error {
    case error(String)
}

protocol ListUseCaseProtocol {
    
    func execute(offset: Int, limit: Int) -> Observable<Result<[PokemonResponse]?, ListUseCaseError>>
    
}
