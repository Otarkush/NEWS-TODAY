//
//  MainViewDataSource.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 19.11.2024.
//

import UIKit
import Models

final class MainViewDataSource {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    private let collectionView: UICollectionView
    private lazy var dataSource: DataSource = makeDataSource()
    
    enum Section: Int, CaseIterable {
        case categories, topHeadlines
    }
    
    enum Item: Hashable {
        case category(Category)
        case topHeadline(Article)
    }
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView.dataSource = dataSource
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .category(let category):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.identifier, for: indexPath) as! CategoriesViewCell
                cell.configure(category: category)
                return cell
            case .topHeadline(let article):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopHeadlinesViewCell.identifier, for: indexPath) as! TopHeadlinesViewCell
                cell.configure(topHeadlines: article)
                return cell
            }
        }
    }
    
    func updateSnapshot(categories: [Category], topHeadlines: [Article]) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(categories.map { Item.category($0) }, toSection: .categories)
        snapshot.appendItems(topHeadlines.map { Item.topHeadline($0) }, toSection: .topHeadlines)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
