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
            DispatchQueue.main.async { [weak self] in
                self?.updateView()
            }
        }
    }
    
    private let disposeBag = DisposeBag()
    internal var viewModel: PokemonListViewModel!
    
    weak var delegate: PokemonListViewControllerDelegate?
    
    // MARK: - UI
    
    private weak var footerView: LoadingFooterView?
    
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
            stateView.heightAnchor.constraint(equalToConstant: Metrics.stateViewHeight)
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.identifier)
        collectionView.register(LoadingFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: LoadingFooterView.identifier)

        // Add Favorites List Button
        handlerFavorites()
    }
     
    // MARK: - Private methods
    
    private func fetchPokemons() {
        viewState = .loading
        viewModel.shouldShowFavorites ? viewModel.loadFavedPokemons() : viewModel.loadPokemons()
    }
    
    private func setupSubscribers() {
        viewModel.viewState.subscribe(onNext: { [weak self] state in
            self?.viewState = state
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didHandlerNotificaation(_:)), name: .pokemonDataModified, object: nil)
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
    
    @objc private func didHandlerNotificaation(_ notification: Notification) {
        // If user not in faved list the reload isn't executed
        guard viewModel.shouldShowFavorites else { return }
        fetchPokemons()
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
    
    // swiftlint:disable line_length
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard !viewModel.shouldShowFavorites,
              kind == UICollectionView.elementKindSectionFooter,
              let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingFooterView.identifier, for: indexPath) as? LoadingFooterView else {
            return UICollectionReusableView()
        }
        
        self.footerView = footerView

        return footerView
    }
    // swiftlint:enable line_length
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard !viewModel.shouldShowFavorites,
              elementKind == UICollectionView.elementKindSectionFooter else { return }

        footerView?.startLoading()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        guard !viewModel.shouldShowFavorites,
              elementKind == UICollectionView.elementKindSectionFooter else { return }

        footerView?.stopLoading()
        footerView?.removeFromSuperview()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !viewModel.shouldShowFavorites else { return }

        viewModel.shouldLoadMoreData(with: indexPath.item)
    }

}
