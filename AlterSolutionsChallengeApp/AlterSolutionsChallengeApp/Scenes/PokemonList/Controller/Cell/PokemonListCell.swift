//
//  PokemonListCell.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 30/08/21.
//

import UIKit
import RxSwift
import AlterSolutionsChallengeCore

protocol PokemonListCellDelegate: AnyObject {
    func didTapFavedButton(_ isFaved: Bool, in index: Int)
}

final class PokemonListCell: UICollectionViewCell, ViewCodeProtocol {
    
    // MARK: - Properties
    
    static let identifier: String = "PokemonListCell"
    
    private var index: Int = -1
    weak var delegate: PokemonListCellDelegate?
    
    private let disposeBag = DisposeBag()
    
    private enum CellMetrics {
        static let fontSize: CGFloat = 14
    }
    
    @DependencyInject
    private var imageDownloader: ImageDownloaderProtocol

    @DependencyInject
    private var favoritesManager: FavoritesManagerProtocol
    
    // MARK: - UI
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: CellMetrics.fontSize)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        return nameLabel
    }()
    
    private lazy var photoView: UIImageView = {
        let photoView = UIImageView(frame: .zero)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.contentMode = .scaleAspectFit
        photoView.addBorder()
        
        return photoView
    }()
    
    private lazy var favedButton: UIButton = {
        let favedButton = UIButton(type: .custom)
        
        favedButton.translatesAutoresizingMaskIntoConstraints = false
        favedButton.setImage(UIImage(systemName: "star"), for: .normal)
        favedButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        favedButton.tintColor = .systemYellow
        
        favedButton.addTarget(self, action: #selector(didTapFavedButton(_:)), for: .touchUpInside)
        
        return favedButton
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    
    func setupHierarchy() {
        contentView.addSubview(photoView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favedButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            favedButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            favedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favedButton.widthAnchor.constraint(equalToConstant: 35),
            favedButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func setupConfigurations() {
        contentView.backgroundColor = .white
        photoView.image = .photoPlaceHolder
        photoView.removeCrossFadeAnimation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoView.image = .photoPlaceHolder
        nameLabel.text = ""
        favedButton.isSelected = false
    }
    
    // MARK: - Public API
    
    func setup(with pokemon: Pokemon, and index: Int) {
        self.index = index

        nameLabel.text = pokemon.name
        favedButton.isSelected = favoritesManager.isFaved(pokemon.name)

        self.accessibilityIdentifier = pokemon.name

        guard let photoURL = URL(string: pokemon.photo) else { return }
        let observable = imageDownloader.download(with: photoURL)
        
        bindObservable(with: observable)
    }
    
    // MARK: - Private methods
    
    private func bindObservable(with observable: Observable<UIImage?>) {
        observable.subscribe { [weak self] image in
            self?.photoView.addCrossFadeAnimation(image)
        }.disposed(by: disposeBag)
    }
    
    @objc private func didTapFavedButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.didTapFavedButton(sender.isSelected, in: index)
    }
    
}
