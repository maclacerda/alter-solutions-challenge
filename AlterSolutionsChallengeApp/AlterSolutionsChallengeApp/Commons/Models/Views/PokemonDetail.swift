//
//  PokemonDetail.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import Foundation

struct PokemonDetail {
    
    // Commom Pokemon data
    private(set) var pokemon: Pokemon
    
    // Specific detail data
    private(set) var specs: PokemonSpecs?
    
    // Computed properties
    var isFaved: Bool {
        get {
            return pokemon.isFaved
        }
        
        set {
            pokemon.isFaved = newValue
        }
    }
    
    var name: String {
        return pokemon.name
    }
    
    var photo: String {
        return pokemon.photo
    }
    
}

struct PokemonSpecs {
    
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
    
    init(_ ability: Abilities) {
        self.slot = ability.slot
        self.name = ability.ability.name
    }
    
}

struct PokemonMoves {
    
    let name: String
    
    init(_ move: Move) {
        self.name = move.name
    }
    
}

struct PokemonStats {
    
    let baseStat: Int
    let name: String
    
    init(_ stats: Stats) {
        self.baseStat = stats.baseStat
        self.name = stats.stat.name
    }
    
}

struct PokemonDetailTypes {
    
    let slot: Int
    let name: String
    
    init(_ pokemonType: PokemonTypes) {
        self.slot = pokemonType.slot
        self.name = pokemonType.type.name
    }
    
}
