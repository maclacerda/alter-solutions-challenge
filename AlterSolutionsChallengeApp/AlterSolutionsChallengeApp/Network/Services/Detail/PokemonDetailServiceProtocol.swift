//
//  PokemonDetailServiceProtocol.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation

protocol PokemonDetailServiceProtocol: AnyObject {
    
    func execute(with identifier: String, handler: @escaping ((Result<PokemonDetailResponse?, DetailUseCaseError>) -> Void))
    
}
