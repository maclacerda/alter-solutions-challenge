//
//  ListableDataView.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 30/08/21.
//

import UIKit
import AlterSolutionsChallengeCore

struct ListableDataViewData {
    
    let key: String
    let value: String
    
}

final class ListableDataView: UIStackView, ViewCodeProtocol {
    
    // MARK: - Properties
    
    private let title: String
    
    // MARK: - Initializer
    
    init(frame: CGRect, title: String) {
        self.title = title
        
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }()
    
    // MARK: - Create items
    
    func bindViews(with items: [ListableDataViewData]) {
        for item in items.map({ makeLabel(with: $0) }) {
            addArrangedSubview(item)
        }
    }
    
    // MARK: - Setup ui
    
    func setupHierarchy() {
        addArrangedSubview(titleLabel)
    }
    
    func setupConstraints() {}
    
    func setupConfigurations() {
        self.axis = .vertical
        self.distribution = .fill
        self.alignment = .fill
        self.spacing = 4
        
        titleLabel.backgroundColor = .primaryColor
    }
    
    // MARK: - Private methods
    
    private func makeLabel(with data: ListableDataViewData) -> UILabel {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = String(format: "%@: %@", data.key, data.value).makeBoldText(separator: ":", position: .before)
        
        return label
    }
    
}
