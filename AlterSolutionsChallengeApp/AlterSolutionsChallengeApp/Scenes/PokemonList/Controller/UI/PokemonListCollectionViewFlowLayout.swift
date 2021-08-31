//
//  PokemonListCollectionViewFlowLayout.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 30/08/21.
//

import UIKit

final class PokemonListCollectionViewFlowLayout {

    class func initialize() -> UICollectionViewCompositionalLayout {
        let size: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Metrics.listItemFractionWidth),
            heightDimension: .absolute(Metrics.listItemHeight)
        )
        
        let footerSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))

        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: PokemonListCollectionViewFlowLayout.itemsPerPage())
        
        group.interItemSpacing = .fixed(Metrics.listItemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
        section.contentInsets = Metrics.listContentInsets
        section.interGroupSpacing = Metrics.defaultMargin
        section.boundarySupplementaryItems = [footer]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Private methods
    
    private class func itemsPerPage() -> Int {
        // TODO: add logic to use data sotre in userdefaults
        return 3
    }

}
