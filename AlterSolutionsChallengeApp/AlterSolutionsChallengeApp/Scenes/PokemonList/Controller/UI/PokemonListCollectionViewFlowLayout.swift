//
//  PokemonListCollectionViewFlowLayout.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 30/08/21.
//

import UIKit

final class PokemonListCollectionViewFlowLayout {
    
    class func initialize() -> UICollectionViewCompositionalLayout {
        let size: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(140))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: PokemonListCollectionViewFlowLayout.itemsPerPage())
        
        group.interItemSpacing = .fixed(5)

        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = Metrics.defaultMargin
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Private methods
    
    private class func itemsPerPage() -> Int {
        // TODO: add logic to use data sotre in userdefaults
        return 3
    }

}
