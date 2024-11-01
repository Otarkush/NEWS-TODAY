//
//  HomeViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

protocol HomeViewPresenter: AnyObject {
    func fetchCategories() -> [Category]
    func viewDidLoad()
}

final class HomeViewController: UIViewController {
  
    //MARK: - Properties
    private let presenter: HomeViewPresenter
    
    let sections = [
        "browse",
        "discover",
        "searchBar",
        "categories"
    ]
    var categories = [Category]()
    enum SectionKind {
        case main
    }
    typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, Int>
    private var dataSource: DataSource!
    
    //MARK: - Init
    init(presenter: HomeViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
//        [titleLabel, subtitleLabel].forEach(view.addSubview)
//        view.addSubview(searchBlockStackView)
//        searchBlockStackView.addArrangedSubview(searchButton)
//        searchBlockStackView.addArrangedSubview(searchTextField)
//        collectionCategoriesView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        
//        collectionView.collectionViewLayout = createLayout()
        
        for (_, sectionTitle) in sections.enumerated() {
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
            setupCollection(sectionTitle: sectionTitle)
            view.addSubview(collectionView)
            configureCategoriesDataSource(sectionTitle: sectionTitle)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
//
//            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//
//            searchBlockStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            searchBlockStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
//            searchBlockStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            searchBlockStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            searchBlockStackView.heightAnchor.constraint(equalToConstant: 56),
//
//            searchButton.leadingAnchor.constraint(equalTo: searchBlockStackView.leadingAnchor, constant: 16),
//            searchButton.widthAnchor.constraint(equalToConstant: 24),
//            searchButton.heightAnchor.constraint(equalToConstant: 24),
//
//            searchTextField.trailingAnchor.constraint(equalTo: searchBlockStackView.trailingAnchor, constant: -16),
            
        ])
    }
    
    private func setupCollection(sectionTitle: String) {
        switch sectionTitle {
        case "browse":
            collectionView.register(LabelViewCell.self, forCellWithReuseIdentifier: LabelViewCell.identifier)
        case "discover":
            collectionView.register(LabelViewCell.self, forCellWithReuseIdentifier: LabelViewCell.identifier)
        case "searchBar":
            collectionView.register(SearchBarViewCell.self, forCellWithReuseIdentifier: SearchBarViewCell.identifier)
        case "categories":
            collectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: CategoriesViewCell.identifier)
        default:
            print("default")
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let spacing: CGFloat = 5
            item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
          
            let containerWidth = layoutEnvironment.container.effectiveContentSize.width
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(85.0), heightDimension: .absolute(42.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous
          
            return section
        }
        return layout
    }
        
    private func configureCategoriesDataSource(sectionTitle: String) {
        switch sectionTitle {
        case "browse":
            dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelViewCell.identifier, for: indexPath) as? LabelViewCell else {
                fatalError("could not dequeue a LabelViewCell")
              }
                
                cell.titleLabel.text = "Browse"
                cell.titleLabel.font = UIFont.InterSemiBold(ofSize: 24)
                cell.titleLabel.textColor = UIColor.blackPrimary
                
                cell.backgroundColor = .systemPurple
                return cell
            })
            
            var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Array(arrayLiteral: 1))
            dataSource.apply(snapshot, animatingDifferences: false)
        case "discover":
            dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelViewCell.identifier, for: indexPath) as? LabelViewCell else {
                fatalError("could not dequeue a LabelViewCell")
              }
                
                cell.titleLabel.text = "Discover things of this world"
                cell.titleLabel.font = UIFont.InterRegular(ofSize: 16)
                cell.titleLabel.textColor = UIColor.greyPrimary
                
                cell.backgroundColor = .systemYellow
                return cell
            })
            
            var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Array(arrayLiteral: 1))
            dataSource.apply(snapshot, animatingDifferences: false)
        case "searchBar":
            dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBarViewCell.identifier, for: indexPath) as? SearchBarViewCell else {
                fatalError("could not dequeue a SearchBarViewCell")
              }
                
                cell.backgroundColor = .systemCyan
                return cell
            })
            
            var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Array(arrayLiteral: 1))
            dataSource.apply(snapshot, animatingDifferences: false)
        case "categories":
            dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.identifier, for: indexPath) as? CategoriesViewCell else {
                fatalError("could not dequeue a CategoriesViewCell")
              }
                
                cell.button.setTitle("\(self.categories[item - 1].name)", for: .normal)
                //TODO
    //            cell.button.addTarget(<#T##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
                cell.backgroundColor = .systemOrange
                return cell
            })
            
            var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
            let countOfItems = Categories.all.count + 1
            snapshot.appendSections([.main])
            snapshot.appendItems(Array(1...countOfItems))
            dataSource.apply(snapshot, animatingDifferences: false)
        default:
            print("default")
        }
        
//        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionCategoriesView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.identifier, for: indexPath) as? CategoriesViewCell else {
//            fatalError("could not dequeue a CategoriesViewCell")
//          }
//            
//            cell.button.setTitle("\(self.categories[item - 1].name)", for: .normal)
//            //TODO
//            cell.button.addTarget(<#T##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
//            cell.backgroundColor = .systemOrange
//            return cell
//        })
//        
//        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
//        let countOfItems = Categories.all.count + 1
//        snapshot.appendSections([.main])
//        snapshot.appendItems(Array(1...countOfItems))
//        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

//MARK: - HomeViewController + HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    func updateUIForCategories(with categories: [Category]) {
        self.categories = [
            Category(name: "Random", emoji: "", id: -1)
        ]
        
        for (index, element) in categories.enumerated() {
            self.categories.append(element)
        }
    }
    
    func updateUIForNewsByCategory(with categories: [Category]) {
        
    }
    
    func updateUIForRecommendedNews(with categories: [Category]) {
        
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        HomeViewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct HomeViewWrapper: UIViewRepresentable {
  
    func makeUIView(context: Context) -> UIView {
        let homeViewController = HomeViewController(presenter: HomeViewPresenterImpl(networking: NetworkingManagerImpl(), router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())))
        
        
        return homeViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
