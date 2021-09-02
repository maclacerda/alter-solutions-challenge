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
    private let limit: Int = 20
    
    internal let viewState = PublishSubject<ViewState>()
    
    weak var delegate: PokemonListViewModelDelegate?
    var pokemons = [Pokemon]()
    var favedPokemons = [Pokemon]()
    var shouldShowFavorites: Bool = false
    var isLoading: Bool = false
    
    @DependencyInject
    private var services: ListUseCaseProtocol
    
    @DependencyInject
    private var analytics: AnalyticsProtocol
    
    @DependencyInject
    private var favedServices: PokemonFavedListServiceProtocol

    // MARK: - API Calls
    
    func loadPokemons() {
        services.execute(offset: offset, limit: limit)
            .subscribe(onNext: { [weak self] (result: Result<[PokemonResponse]?, ListUseCaseError>) in
                switch result {
                case .success(let data):
                    guard let response = data, !response.isEmpty else {
                        self?.viewState.onNext(.empty("No Pokemons found, please try again."))
                        return
                    }

                    self?.makePokemonsData(with: response)
                    self?.isLoading = false
                    self?.viewState.onNext(.loaded)

                case .failure(let error):
                    self?.viewState.onNext(.error(error))
                }
        }).disposed(by: disposeBag)
    }
    
    func loadFavedPokemons() {
        favedPokemons = favedServices.execute()
        
        guard !favedPokemons.isEmpty else {
            viewState.onNext(.empty("No faved Pokemons found, please faved one and try again."))
            return
        }
        
        viewState.onNext(.loaded)
    }
    
    func shouldLoadMoreData(with index: Int) {
        guard !pokemons.isEmpty, index == pokemons.count - 1 && !isLoading else {
            return
        }
        
        // Apply the little delay to user see the loading more items indicator
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.performLoadMoreData()
        }
    }
    
    func showDetailsForPokemon(with index: Int) {
        let pokemon = pokemons[index]
        let pokemonDetail = makePokemonDetailData(with: pokemon)
        
        delegate?.showDetailsForPokemon(with: pokemonDetail)
    }
    
    func updatePokemonFavedStatus(with index: Int, isFaved: Bool) {
        var pokemon = pokemons[index]
        pokemon.isFaved = isFaved
    }
    
    func sendEvent(with index: Int) {
        let pokemon = pokemons[index]
        let parameters = pokemon.buildAnalyticsParams()

        analytics.sendEvent(with: AnalyticEvents.pokemonDataChanged.rawValue, parameters: parameters)
    }
    
    // MARK: - Private methods
    
    private func performLoadMoreData() {
        isLoading = !isLoading
        updateOffset()
        loadPokemons()
    }
    
    private func updateOffset() {
        offset += limit
    }
    
    private func makePokemonsData(with response: [PokemonResponse]) {
        pokemons.append(contentsOf: response.map {
            // TODO: rever isFaved depois
            return Pokemon(name: $0.name.capitalized, photo: $0.url.extractPokemonIdentifier().makeAvatarURL(), isFaved: false)
        })
    }
    
    private func makePokemonDetailData(with pokemon: Pokemon) -> PokemonDetail {
        return PokemonDetail(pokemon: pokemon)
    }
    
}
