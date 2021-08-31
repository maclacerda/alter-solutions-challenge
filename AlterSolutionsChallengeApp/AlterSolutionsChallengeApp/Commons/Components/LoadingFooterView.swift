//
//  LoadingFooterView.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import UIKit
import AlterSolutionsChallengeCore

final class LoadingFooterView: UICollectionReusableView, ViewCodeProtocol {
    
    // MARK: - Properties
    
    static let identifier: String = "LoadingFooterView"
    
    override var reuseIdentifier: String? {
        return LoadingFooterView.identifier
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .primaryColor
        
        return indicatorView
    }()
    
    // MARK: - Build view
    
    func setupHierarchy() {
        addSubview(indicatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupConfigurations() {
        backgroundColor = .clear
    }
    
    // MARK: - Public API
    
    func startLoading() {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    func stopLoading() {
        indicatorView.stopAnimating()
    }

}
