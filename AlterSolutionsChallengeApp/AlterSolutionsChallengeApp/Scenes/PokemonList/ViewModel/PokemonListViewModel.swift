//
//  PokemonListViewModel.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 29/08/21.
//

import Foundation
import RxSwift
import AlterSolutionsChallengeCore

protocol PokemonListViewModelDelegate: AnyObject {
    
    func showDetailsForPokemon(with pokemon: PokemonDetail)
    
}

final class PokemonListViewModel {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private(set) var offset: Int = 0
    private(set) var limit: Int = 0
    
    internal let viewState = PublishSubject<ViewState>()
    
    weak var delegate: PokemonListViewModelDelegate?
    var pokemons = [Pokemon]()
    var favedPokemons = [Pokemon]()
    var shouldShowFavorites: Bool = false
    
    @DependencyInject
    private var services: ListUseCaseProtocol

    // MARK: - API Calls
    
    func loadPokemons(_ inPullToRefresh: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.pokemons.removeAll()
            self.pokemons.append(contentsOf: [
                Pokemon(name: "Bulbasaur", photo: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", isFaved: false),
                Pokemon(name: "Ivysaur", photo: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png", isFaved: false),
                Pokemon(name: "Venusaur", photo: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png", isFaved: false),
                Pokemon(name: "Charmander", photo: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png", isFaved: false),
                Pokemon(name: "Charmeleon", photo: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png", isFaved: false),
                Pokemon(name: "Charizard", photo: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png", isFaved: false)
            ])
            
            self.viewState.onNext(.loaded)
        }
        
        return
        
        offset = inPullToRefresh ? 0 : offset + limit
        
        if inPullToRefresh {
            pokemons.removeAll()
        }
        
        services.execute(offset: offset, limit: limit)
            .subscribe(onNext: { [weak self] (result: Result<[PokemonResponse]?, ListUseCaseError>) in
                switch result {
                case .success(let data):
                    guard let response = data, !response.isEmpty else {
                        self?.viewState.onNext(.empty("No Pokemons found, please try again."))
                        return
                    }
                    
                    self?.makePokemonsData(with: response)
                    self?.viewState.onNext(.loaded)
                case .failure(let error):
                    self?.viewState.onNext(.error(error))
                }
        }).disposed(by: disposeBag)
    }
    
    func loadFavedPokemons() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.viewState.onNext(.loaded)
        }
    }
    
    func showDetailsForPokemon(with index: Int) {
        let pokemon = pokemons[index]
        let pokemonDetail = makePokemonDetailData(with: pokemon)
        
        delegate?.showDetailsForPokemon(with: pokemonDetail)
    }
    
    // MARK: - Private methods
    
    private func makePokemonsData(with response: [PokemonResponse]) {
        pokemons.append(contentsOf: response.map {
            // TODO: rever isFaved depois
            return Pokemon(name: $0.name.capitalized, photo: $0.url.makeAvatarURL(), isFaved: false)
        })
    }
    
    private func makePokemonDetailData(with pokemon: Pokemon) -> PokemonDetail {
        return PokemonDetail(
            name: pokemon.name,
            photo: pokemon.photo,
            isFaved: pokemon.isFaved,
            initialExperience: 64,
            height: 7,
            weight: 69,
            abilities: [
                PokemonAbilities(slot: 1, name: "overgrow"),
                PokemonAbilities(slot: 3, name: "chlorophyll")
            ],
            moves: [
                PokemonMoves(name: "razor-wind"),
                PokemonMoves(name: "swords-dance"),
                PokemonMoves(name: "cut"),
                PokemonMoves(name: "bind"),
                PokemonMoves(name: "vine-whip")
            ],
            stats: [
                PokemonStats(baseStat: 45, name: "hp"),
                PokemonStats(baseStat: 49, name: "attack"),
                PokemonStats(baseStat: 49, name: "defense"),
                PokemonStats(baseStat: 65, name: "special-attack")
            ],
            types: [
                PokemonDetailTypes(slot: 1, name: "grass"),
                PokemonDetailTypes(slot: 2, name: "poison")
            ]
        )
    }
    
}
