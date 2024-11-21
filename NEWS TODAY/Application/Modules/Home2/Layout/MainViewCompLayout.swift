//
//  MainViewCompLayout.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 19.11.2024.
//

import UIKit

final class MainViewCompLayout {
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch Section(rawValue: sectionIndex) {
            case .categories:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.2),
                    heightDimension: .fractionalHeight(1)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.1)
                )
    
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case .topHeadlines:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(256),
                    heightDimension: .absolute(256)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 12,
                    leading: 8,
                    bottom: 24,
                    trailing: 8
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(272),
                    heightDimension: .absolute(296)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                
                return section
         
            default:
                assertionFailure()
                return nil
            }
        }
        return layout
    }
}
