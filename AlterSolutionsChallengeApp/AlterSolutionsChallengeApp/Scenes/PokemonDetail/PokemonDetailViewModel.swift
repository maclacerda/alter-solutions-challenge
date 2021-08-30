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
    
}

final class PokemonDetailViewModel {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    internal var pokemon: PokemonDetail
    internal let viewState = PublishSubject<ViewState>()
    
    weak var delegate: PokemonDetailViewModelDelegate?
    
    @DependencyInject
    private var services: DetailUseCaseProtocol
    
    // MARK: - Initializer
    
    init(with pokemon: PokemonDetail) {
        self.pokemon = pokemon
    }

    // MARK: - API Calls
    
    func fetchPokemonDetail() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.viewState.onNext(.loaded)
        }
        
        return
        
//        offset = inPullToRefresh ? 0 : offset + limit
//
//        if inPullToRefresh {
//            pokemons.removeAll()
//        }
//
//        services.execute(offset: offset, limit: limit)
//            .subscribe(onNext: { [weak self] (result: Result<[PokemonResponse]?, ListUseCaseError>) in
//                switch result {
//                case .success(let data):
//                    guard let response = data, !response.isEmpty else {
//                        self?.viewState.onNext(.empty("No Pokemon details found, please try again."))
//                        return
//                    }
//
//                    self?.makePokemonsData(with: response)
//                    self?.viewState.onNext(.loaded)
//                case .failure(let error):
//                    self?.viewState.onNext(.error(error))
//                }
//        }).disposed(by: disposeBag)
    }
    
    // MARK: - Private methods
//
//    private func makePokemonsData(with response: [PokemonResponse]) {
//        pokemons.append(contentsOf: response.map {
//            // TODO: rever isFaved depois
//            return Pokemon(name: $0.name.capitalized, photo: $0.url.makeAvatarURL(), isFaved: false)
//        })
//    }
    
}
