//
//  PokemonDetailViewController.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit
import RxSwift
import AlterSolutionsChallengeCore

class PokemonDetailViewController: BaseViewController, ViewCodeProtocol {
    
    // MARK: - Properties
    
    private var viewState: ViewState = .loading {
        didSet {
            updateView()
        }
    }
    
    private let disposeBag = DisposeBag()
    internal var viewModel: PokemonDetailViewModel!
    
    weak var delegate: PokemonDetailViewControllerDelegate?
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.decelerationRate = .fast
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        
        return contentView
    }()
    
    private lazy var detailView: PokemonDetailDescritionView = {
        let detailView = PokemonDetailDescritionView(with: viewModel.pokemon)
        
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        return detailView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubscribers()
        
        fetchPokemonDetail()
    }
    
    // MARK: - UI Methods
    
    func setupHierarchy() {
        view.addSubview(scrollView)
        view.addSubview(stateView)
        view.addSubview(loadingView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(detailView)
    }
    
    func setupConstraints() {
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        
        contentViewHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.defaultMargin),
            stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.defaultMargin),
            stateView.heightAnchor.constraint(equalToConstant: 240),
            
            scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentViewHeightConstraint,
            
            detailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.defaultMargin),
            detailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupConfigurations() {
        // Main View
        title = "Details"
        view.backgroundColor = .white
        
        // Loader
        loadingView.color = .primaryColor
        loadingView.hidesWhenStopped = true
        loadingView.startAnimating()
        
        // Add Favorites List Button
        handlerFavorites()
    }
    
    // MARK: - Private methods
    
    private func fetchPokemonDetail() {
        viewState = .loading
        viewModel.fetchPokemonDetail()
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
            
            scrollView.isHidden = true
            loadingView.stopAnimating()
            
            stateView.updateView(with: viewState) { [weak self] in
                self?.fetchPokemonDetail()
            }
            
        case .loaded:
            scrollView.isHidden = false
            
            loadingView.stopAnimating()
            stateView.isHidden = true
            
        case .loading:
            loadingView.isHidden = false
            loadingView.startAnimating()
            
            scrollView.isHidden = true
            stateView.isHidden = true
        }
    }
    
    private func handlerFavorites() {
        addCustomNavigationButton(on: .right, icon: viewModel.pokemon.isFaved ? .favorites : .list, tintColor: .systemYellow, action: self)
    }
    
    private func addPokemonToFavorites() {
        handlerFavorites()
    }
    
    private func removePokemonToFavorites() {
        handlerFavorites()
    }
    
}

extension PokemonDetailViewController: CustomButtonActionDelegate {
    
    func didTapCustomNavigationButton() {
        viewModel.pokemon.isFaved = !viewModel.pokemon.isFaved
    }
    
}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    
}
