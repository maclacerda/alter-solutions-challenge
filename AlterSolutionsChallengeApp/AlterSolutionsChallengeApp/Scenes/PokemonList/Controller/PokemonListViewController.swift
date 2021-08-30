//
//  PokemonListViewController.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit
import RxSwift
import AlterSolutionsChallengeCore

class PokemonListViewController: BaseViewController, ViewCodeProtocol {
    
    // MARK: - Properties
    
    private var viewState: ViewState = .loading {
        didSet {
            updateView()
        }
    }
    
    private let disposeBag = DisposeBag()
    internal var viewModel: PokemonListViewModel!
    
    weak var delegate: PokemonListViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .large)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        return loadingView
    }()
    
    private lazy var stateView: StateView = {
        let stateView = StateView(frame: .zero)
        
        stateView.translatesAutoresizingMaskIntoConstraints = false
        stateView.isHidden = true
        
        return stateView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = PokemonListCollectionViewFlowLayout.initialize()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubscribers()
        
        fetchPokemons()
    }
    
    // MARK: - UI Methods
    
    func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(stateView)
        view.addSubview(loadingView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            
            stateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.defaultMargin),
            stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.defaultMargin),
            stateView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func setupConfigurations() {
        // Main View
        title = "Pokemons"
        view.backgroundColor = .white
        
        // Loader
        loadingView.color = .primaryColor
        loadingView.hidesWhenStopped = true
        loadingView.startAnimating()
        
        // CollectionView
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.identifier)
        
        // Add Favorites List Button
        handlerFavorites()
    }
    
    // MARK: - Private methods
    
    private func fetchPokemons(_ inPullToRefresh: Bool = false) {
        viewState = .loading
        viewModel.shouldShowFavorites ? viewModel.loadFavedPokemons() : viewModel.loadPokemons(inPullToRefresh)
    }
    
    private func setupSubscribers() {
        viewModel.viewState.subscribe(onNext: { [weak self] state in
            self?.viewState = state
        }).disposed(by: disposeBag)
    }
    
    private func updateView() {
        switch viewState {
        case .empty, .error:
            stateView.isHidden = false
            
            collectionView.isHidden = true
            loadingView.stopAnimating()
            
            stateView.updateView(with: viewState) { [weak self] in
                self?.fetchPokemons()
            }
            
        case .loaded:
            collectionView.isHidden = false
            collectionView.reloadData()
            
            loadingView.stopAnimating()
            stateView.isHidden = true
            
        case .loading:
            loadingView.isHidden = false
            loadingView.startAnimating()
            
            collectionView.isHidden = true
            stateView.isHidden = true
        }
    }
    
    private func handlerFavorites() {
        addCustomNavigationButton(on: .right, icon: viewModel.shouldShowFavorites ? .favorites : .list, action: self)
    }
    
    private func showFavorites() {
        fetchPokemons()
        handlerFavorites()
    }
    
    private func showPokemons() {
        fetchPokemons()
        handlerFavorites()
    }
    
}

extension PokemonListViewController: CustomButtonActionDelegate {
    
    func didTapCustomNavigationButton() {
        viewModel.shouldShowFavorites = !viewModel.shouldShowFavorites
        viewModel.shouldShowFavorites ? showFavorites() : showPokemons()
    }
    
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    
    func showDetailsForPokemon(with pokemon: PokemonDetail) {
        delegate?.didSelectPokemon(pokemon)
    }
    
}

extension PokemonListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.shouldShowFavorites ? viewModel.favedPokemons.count : viewModel.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonListCell.identifier, for: indexPath)
                as? PokemonListCell else {
            return UICollectionViewCell()
        }

        let pokemon = viewModel.shouldShowFavorites ? viewModel.favedPokemons[indexPath.row] : viewModel.pokemons[indexPath.row]
        cell.setup(with: pokemon)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetailsForPokemon(with: indexPath.row)
    }
    
}
