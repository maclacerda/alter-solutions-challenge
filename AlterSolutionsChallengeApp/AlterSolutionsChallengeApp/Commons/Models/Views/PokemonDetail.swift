//
//  PokemonDetail.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import Foundation

struct PokemonDetail {
    
    // Commom Pokemon data
    let name: String
    let photo: String
    
    var isFaved: Bool
    
    // Specific detail data
    let initialExperience: Int
    let height: Int
    let weight: Int
    let abilities: [PokemonAbilities]
    let moves: [PokemonMoves]
    let stats: [PokemonStats]
    let types: [PokemonDetailTypes]
    
}

struct PokemonAbilities {
    
    let slot: Int
    let name: String
    
}

struct PokemonMoves {
    
    let name: String
    
}

struct PokemonStats {
    
    let baseStat: Int
    let name: String
    
}

struct PokemonDetailTypes {
    
    let slot: Int
    let name: String
    
}
