//
//  PokemonDetailViewModel.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 30/08/21.
//

import Foundation
import RxSwift
import AlterSolutionsChallengeCore

protocol PokemonDetailViewModelDelegate: AnyObject {

    func didNotifyFavedUnFavedPokemon()

}

final class PokemonDetailViewModel {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    internal var pokemonDetail: PokemonDetail
    internal let viewState = PublishSubject<ViewState>()
    
    weak var delegate: PokemonDetailViewModelDelegate?
    
    @DependencyInject
    private var services: DetailUseCaseProtocol
    
    @DependencyInject
    private var analytics: AnalyticsProtocol
    
    // MARK: - Initializer
    
    init(with pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }

    // MARK: - Public API
    
    func fetchPokemonDetail() {
        services.execute(with: pokemonDetail.name)
            .subscribe(onNext: { [weak self] (result: Result<PokemonDetailResponse?, DetailUseCaseError>) in
                switch result {
                case .success(let data):
                    guard let response = data else {
                        self?.viewState.onNext(.empty("No Pokemon details found, please try again."))
                        return
                    }
                    
                    self?.updatePokemonData(with: response)
                    self?.viewState.onNext(.loaded)
                case .failure(let error):
                    self?.viewState.onNext(.error(error))
                }
            }).disposed(by: disposeBag)
    }
    
    func notifyPokemonChanged() {
        delegate?.didNotifyFavedUnFavedPokemon()
    }
    
    func sendEvent() {
        let parameters = pokemonDetail.buildAnalyticsParams()
        analytics.sendEvent(with: AnalyticEvents.pokemonDataChanged.rawValue, parameters: parameters)
    }
    
    // MARK: - Private methods

    private func updatePokemonData(with response: PokemonDetailResponse) {
        pokemonDetail = PokemonDetail(
            pokemon: pokemonDetail.pokemon,
            specs: PokemonSpecs(
                initialExperience: response.baseExperience,
                height: response.height,
                weight: response.weight,
                abilities: response.abilities.map({ PokemonAbilities($0) }),
                moves: response.moves.map({ PokemonMoves($0.move) }),
                stats: response.stats.map({ PokemonStats($0) }),
                types: response.types.map({ PokemonDetailTypes($0) })
            )
        )
    }
    
}
