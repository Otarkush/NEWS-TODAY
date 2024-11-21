//
//  MainViewDataSource.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 19.11.2024.
//

import UIKit
import Models

protocol MainViewDataSource: AnyObject {
    #warning("Может убрать ассоц знаечния? Чтобы any не использовать при имплементации")
    associatedtype Section: Hashable, CaseIterable
    associatedtype Item: Hashable
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    var collectionView: UICollectionView { get }
    var dataSource: DataSource { get }
    
    func makeDataSource() -> DataSource
    func updateSnapshot(categories: [Category], topHeadlines: [Article])
}

final class MainViewDataSourceImpl: MainViewDataSource {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    let collectionView: UICollectionView
    lazy var dataSource: DataSource = makeDataSource()
    
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
    
    internal func makeDataSource() -> DataSource {
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
    
    internal func updateSnapshot(categories: [Category], topHeadlines: [Article]) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(categories.map { Item.category($0) }, toSection: .categories)
        snapshot.appendItems(topHeadlines.map { Item.topHeadline($0) }, toSection: .topHeadlines)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
