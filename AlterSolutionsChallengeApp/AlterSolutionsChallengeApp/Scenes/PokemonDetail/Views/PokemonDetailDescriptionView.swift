//
//  PokemonDetailDescriptionView.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 30/08/21.
//

import UIKit
import AlterSolutionsChallengeCore
import RxSwift

final class PokemonDetailDescritionView: UIView, ViewCodeProtocol {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    @DependencyInject
    private var imageDownloader: ImageDownloaderProtocol
    
    var pokemon: PokemonDetail? {
        didSet {
            setupPokemonInfo()
        }
    }
    
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var photoView: UIImageView = {
        let photoView = UIImageView(frame: .zero)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.image = .photoPlaceHolder
        photoView.contentMode = .scaleAspectFit
        photoView.clipsToBounds = true
        photoView.backgroundColor = .white
        photoView.addBorder(
            traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        )
        
        photoView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        return photoView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: Metrics.defaultMargin)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        nameLabel.numberOfLines = 1
        
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        return nameLabel
    }()
    
    private lazy var generalDataView: ListableDataView = {
        let generalDataView = ListableDataView(frame: .zero, title: "General Info")
        
        generalDataView.translatesAutoresizingMaskIntoConstraints = false
        
        return generalDataView
    }()
    
    private lazy var abilitiesDataView: ListableDataView = {
        let abilitiesDataView = ListableDataView(frame: .zero, title: "Abilities")
        
        abilitiesDataView.translatesAutoresizingMaskIntoConstraints = false
        
        return abilitiesDataView
    }()
    
    private lazy var movesDataView: ListableDataView = {
        let movesDataView = ListableDataView(frame: .zero, title: "Moves")
        
        movesDataView.translatesAutoresizingMaskIntoConstraints = false
        
        return movesDataView
    }()
    
    private lazy var statsDataView: ListableDataView = {
        let statsDataView = ListableDataView(frame: .zero, title: "Stats")
        
        statsDataView.translatesAutoresizingMaskIntoConstraints = false
        
        return statsDataView
    }()
    
    private lazy var typesDataView: ListableDataView = {
        let typesDataView = ListableDataView(frame: .zero, title: "Types")
        
        typesDataView.translatesAutoresizingMaskIntoConstraints = false
        
        return typesDataView
    }()
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Build view
    
    func setupHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(photoView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(generalDataView)
        contentView.addSubview(abilitiesDataView)
        contentView.addSubview(movesDataView)
        contentView.addSubview(statsDataView)
        contentView.addSubview(typesDataView)
    }
    
    func setupConstraints() {
        let typesBottomConstraint = typesDataView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        typesBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.defaultMargin),
            photoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: photoView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: photoView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: photoView.bottomAnchor),
            
            generalDataView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: Metrics.defaultMargin),
            generalDataView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.defaultMargin),
            generalDataView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.defaultMargin),
            
            abilitiesDataView.topAnchor.constraint(equalTo: generalDataView.bottomAnchor, constant: Metrics.defaultMargin),
            abilitiesDataView.leadingAnchor.constraint(equalTo: generalDataView.leadingAnchor),
            abilitiesDataView.trailingAnchor.constraint(equalTo: generalDataView.trailingAnchor),
            
            movesDataView.topAnchor.constraint(equalTo: abilitiesDataView.bottomAnchor, constant: Metrics.defaultMargin),
            movesDataView.leadingAnchor.constraint(equalTo: abilitiesDataView.leadingAnchor),
            movesDataView.trailingAnchor.constraint(equalTo: abilitiesDataView.trailingAnchor),
            
            statsDataView.topAnchor.constraint(equalTo: movesDataView.bottomAnchor, constant: Metrics.defaultMargin),
            statsDataView.leadingAnchor.constraint(equalTo: movesDataView.leadingAnchor),
            statsDataView.trailingAnchor.constraint(equalTo: movesDataView.trailingAnchor),
            
            typesDataView.topAnchor.constraint(equalTo: statsDataView.bottomAnchor, constant: Metrics.defaultMargin),
            typesDataView.leadingAnchor.constraint(equalTo: statsDataView.leadingAnchor),
            typesDataView.trailingAnchor.constraint(equalTo: statsDataView.trailingAnchor),
            typesBottomConstraint
        ])
    }
    
    func setupConfigurations() {
        contentView.backgroundColor = .clear
    }
    
    // MARK: - Private methods
    
    private func setupPokemonInfo() {
        guard let pokemon = self.pokemon,
              let specs = pokemon.specs else {
            return
        }
        
        nameLabel.text = pokemon.name
        
        // Make lists
        makeGeneralInfo(specs)
        makeAbilities(specs)
        makeMoves(specs)
        makeStats(specs)
        makeTypes(specs)
        
        guard let photoURL = URL(string: pokemon.photo) else { return }
        let observable = imageDownloader.download(with: photoURL)
        
        bindObservable(with: observable)
    }
    
    private func makeGeneralInfo(_ specs: PokemonSpecs) {
        let infos = [
            ListableDataViewData(key: "Initial Experience", value: "\(specs.initialExperience)"),
            ListableDataViewData(key: "Height", value: "\(specs.height)"),
            ListableDataViewData(key: "Weight", value: "\(specs.weight)")
        ]
        
        generalDataView.bindViews(with: infos)
    }
    
    private func makeAbilities(_ specs: PokemonSpecs) {
        let abilities = specs.abilities.map {
            ListableDataViewData(
                key: "Ability name / Slot",
                value: String(format: "%@ / %i", $0.name, $0.slot)
            )
        }
        
        abilitiesDataView.bindViews(with: abilities)
    }
    
    private func makeMoves(_ specs: PokemonSpecs) {
        let moves = specs.moves.map {
            ListableDataViewData(key: "Move name", value: $0.name)
        }
        
        movesDataView.bindViews(with: moves)
    }
    
    private func makeStats(_ specs: PokemonSpecs) {
        let stats = specs.stats.map {
            ListableDataViewData(
                key: "Stat name / Base Stat",
                value: String(format: "%@ / %i", $0.name, $0.baseStat)
            )
        }
        
        statsDataView.bindViews(with: stats)
    }
    
    private func makeTypes(_ specs: PokemonSpecs) {
        let types = specs.types.map {
            ListableDataViewData(
                key: "Type name / Slot",
                value: String(format: "%@ / %i", $0.name, $0.slot)
            )
        }
        
        typesDataView.bindViews(with: types)
    }
    
    private func bindObservable(with observable: Observable<UIImage?>) {
        observable.subscribe { [weak self] image in
            self?.photoView.addCrossFadeAnimation(image)
        }.disposed(by: disposeBag)
    }
    
}
