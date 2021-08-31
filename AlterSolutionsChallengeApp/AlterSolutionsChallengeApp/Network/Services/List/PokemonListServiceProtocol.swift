//
//  PokemonListServiceProtocol.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation

protocol PokemonListServiceProtocol: AnyObject {
    
    func execute(offset: Int, limit: Int, handler: @escaping ((Result<[PokemonResponse]?, ListUseCaseError>) -> Void))
    
}
