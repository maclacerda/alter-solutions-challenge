//
//  StateView.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 29/08/21.
//

import UIKit
import AlterSolutionsChallengeCore

final class StateView: UIView, ViewCodeProtocol {
    
    // MARK: - Properties
    
    private var retryAction: (() -> Void)?
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        
        return containerView
    }()
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.tintColor = .primaryColor
        
        return iconView
    }()
    
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel(frame: .zero)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        return messageLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.roundCorners(with: .primaryColor)
        
        button.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI methods
    
    func setupHierarchy() {
        addSubview(containerView)
        
        containerView.addSubview(iconView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Metrics.defaultMargin),
            iconView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 80),
            iconView.heightAnchor.constraint(equalToConstant: 80),
            
            messageLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: Metrics.defaultMargin),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.defaultMargin),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.defaultMargin),
            
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupConfigurations() {
        backgroundColor = .clear
    }
    
    // MARK: - Private methods
    
    @objc private func didButtonTap() {
        retryAction?()
    }
    
    // MARK: - Public methods
    
    func updateView(with state: ViewState, retryAction: (() -> Void)? = nil) {
        switch state {
        case .empty(let message):
            iconView.image = UIImage(systemName: "smallcircle.circle.fill")
            messageLabel.text = message
            self.retryAction = retryAction
        
        case .error(let error):
            iconView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            messageLabel.text = error?.localizedDescription ?? "An unknow error occurred, please try again."
            self.retryAction = retryAction
            
        default: break
        }
    }
    
}
