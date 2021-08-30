//
//  PokemonDetailResponse.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 29/08/21.
//

import Foundation

struct PokemonDetailResponse: Codable {
    
    let baseExperience: Int
    let height: Int
    let weight: Int
    let abilities: [Abilities]
    let moves: [Moves]
    let stats: [Stats]
    let types: [PokemonTypes]
    
    private enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height
        case weight
        case abilities
        case moves
        case stats
        case types
    }
    
}

struct Abilities: Codable {
    
    let slot: Int
    let ability: Ability
    
}

struct Ability: Codable {
    
    let name: String
    
}

struct Moves: Codable {
    
    let move: Move
    
    private enum CodingKeys: String, CodingKey {
        case move
    }
    
}

struct Move: Codable {
    
    let name: String
    
}

struct Stats: Codable {
    
    let baseStat: Int
    let stat: Stat
    
    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
    
}

struct Stat: Codable {
    
    let name: String
    
}

struct PokemonTypes: Codable {
    
    let slot: Int
    let type: PokemonTypeDetail
    
}

struct PokemonTypeDetail: Codable {
    
    let name: String
    
}
