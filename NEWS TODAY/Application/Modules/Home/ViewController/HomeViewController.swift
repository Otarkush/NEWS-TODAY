////
////  HomeViewController.swift
////  NEWS TODAY
////
////  Created by Daniil Murzin on 22.10.2024.
////  Modifyed by Aria Arisova (relied to my fucked up mental)
//
//import UIKit
//import SwiftUI
//import Repository
//import Models
//
//protocol HomeViewPresenter: AnyObject {
//    func fetchCategories() -> [Category]
//    func viewDidLoad()
//}
//
//protocol SearchBarViewCellDelegate: AnyObject {
//    func didUpdateSearchQuery(_ query: String)
//}
//
//final class HomeViewController: UIViewController {
//  
//    //MARK: - Properties
//    private let presenter: HomeViewPresenter
//    var categoriesArray = [Category]()
//    var browseArray = [NewHeadersTitles]()
//    var discoverArray = [NewHeadersTitles]()
//    var searchBarArray = [NewSearchBar]()
//    var topHeadlinesArray = [Article]()
////    var recommendedSeeAll = [NewRecommendedTitles]()
////    var recommendedHeadlines = [News]()
//    
//    
//    //MARK: - Init
//    init(presenter: HomeViewPresenter) {
//        self.presenter = presenter
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - UI
//    
//    private var collectionView: UICollectionView!
//    private var dataSource: DataSource!
//    
//    //MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupUI()
//        setupConstraints()
//        presenter.viewDidLoad()
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .white
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
////        collectionView.register(LabelViewCell.self, forCellWithReuseIdentifier: LabelViewCell.identifier)
//        collectionView.register(SearchBarViewCell.self, forCellWithReuseIdentifier: SearchBarViewCell.identifier)
//        collectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: CategoriesViewCell.identifier)
//        collectionView.register(TopHeadlinesViewCell.self, forCellWithReuseIdentifier: TopHeadlinesViewCell.identifier)
////        collectionView.register(LabelButtonViewCell.self, forCellWithReuseIdentifier: LabelButtonViewCell.identifier)
////        collectionView.register(RecommendedBookmarksViewCell.self, forCellWithReuseIdentifier: RecommendedBookmarksViewCell.identifier)
//        addElements()
//        dataSource = makeDataSource()
////        collectionView.dataSource = dataSource //??? wtf эта строка ни на что не влияет???????!!!!!!!1
//        view.addSubview(collectionView)
//    }
//    
//    func addElements() {
//        browseArray = [
//            NewHeadersTitles(id: "", title: "Browse", font: UIFont.InterSemiBold(ofSize: 24)!, textColor: UIColor.blackPrimary)
//        ]
//        discoverArray = [
//            NewHeadersTitles(id: "", title: "Discover things of this world", font: UIFont.InterRegular(ofSize: 16)!, textColor: UIColor.greyPrimary)
//        ]
//        searchBarArray = [
//            NewSearchBar(id: "")
//        ]
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//        ])
//    }
//    
//    enum Section: Int {
//        case browser = 0
//        case discover
//        case searchBar
//        case categories
//        case topHeadlines
////        case recommended
//    }
//    
//    private func applySnapshot() {
//        var snapshot = DataSnapshot()
//        snapshot.appendSections(UISection.allCases)
//        snapshot.appendItems(browseArray.map(UIItem.browser), toSection: .browser)
//        snapshot.appendItems(discoverArray.map(UIItem.discover), toSection: .discover)
//        snapshot.appendItems(searchBarArray.map(UIItem.searchBar), toSection: .searchBar)
//        snapshot.appendItems(categoriesArray.map(UIItem.category), toSection: .category)
//        snapshot.appendItems(topHeadlinesArray.map(UIItem.topHeadline), toSection: .topHeadline)
//        
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
//    
//    private func createLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//            switch Section(rawValue: sectionIndex) {
//            case .browser:
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                return section
//            case .discover:
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                return section
//            case .searchBar:
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                return section
//            case .categories:
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .continuous
//                return section
//            case .topHeadlines:
//                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(256), heightDimension: .absolute(256))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 24, trailing: 8)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(272), heightDimension: .absolute(296))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .continuous
//                return section
////            case .recommended:
////                #warning("TO DO: Make section")
////                return nil
//                
//            default:
//                assertionFailure()
//                return nil
//            }
//        }
//        
//        return layout
//    }
//}
//
////MARK: - HomeViewController + SearchBarViewCellDelegate
//extension HomeViewController: SearchBarViewCellDelegate {
//    func didUpdateSearchQuery(_ query: String) {
//        
//        print("Поисковый запрос в HomeViewController: \(query)")
//    }
//}
//
////MARK: - HomeViewController + HomeViewDelegate
//extension HomeViewController: HomeViewDelegate {
//    func updateUIForCategories(with categories: [Category]) {
//        self.categoriesArray = [
//            Category(name: "Random", emoji: "", id: -1)
//        ]
//        
//        for (_, element) in categories.enumerated() {
//            self.categoriesArray.append(element)
//        }
//    }
//    
//    func updateUIForNewsByCategory(with news: [Article]) {
//        self.topHeadlinesArray = news
//        applySnapshot()
//    }
//    
//    func updateUIForRecommendedNews(with news: [Article]) {
//        
//    }
//}
//struct HomeViewModel {
//    let browser: [NewHeadersTitles]
//    let discover: [NewHeadersTitles]
//    let searchBar: [NewSearchBar]
//    let categories: [Category]
//    let topHeadlines: [Article]
////    let header: Header
////    let recommended: [NewsArticle]
//    
//    struct Header {
//        let title: String
//        let buttonText: String
//        let action: () -> Void
//    }
//}
//
//struct NewHeadersTitles: Hashable {
//    let id: String
//    let title: String
//    let font: UIFont
//    let textColor: UIColor
//}
//
//struct NewSearchBar: Hashable {
//    let id: String
//}
//
////struct NewsArticle: Hashable {
////    let id: String
////}
//
//private extension HomeViewController {
//    
//    enum UISection: Int, Hashable, CaseIterable {
//        case browser = 0, discover, searchBar, category, topHeadline/*, recommended*/
//    }
//    
//    enum UIItem: Hashable {
//        case browser(NewHeadersTitles)
//        case discover(NewHeadersTitles)
//        case searchBar(NewSearchBar)
//        case category(Category)
//        case topHeadline(Article)
////        case recommended(NewsArticle)
//        
//        var identifier: String {
//            switch self {
//            case .browser: LabelViewCell.identifier
//            case .discover: LabelViewCell.identifier
//            case .searchBar: SearchBarViewCell.identifier
//            case .category: CategoriesViewCell.identifier
//            case .topHeadline: TopHeadlinesViewCell.identifier
////            case .recommended: "recommendedIdentifier"
//            }
//        }
//    }
//    
//    typealias DataSource = UICollectionViewDiffableDataSource<UISection, UIItem>
//    typealias DataSnapshot = NSDiffableDataSourceSnapshot<UISection, UIItem>
//    
//    func dataSource(render viewModel: HomeViewModel) {
////        let header = collectionView.supplementaryView(
////            forElementKind: UICollectionView.elementKindSectionHeader,
////            at: IndexPath(
////                item: 0,
////                section: UISection.recommended.rawValue
////            )
////        ) as? CollectionHeader
////        header?.configure(viewModel.header)
//        Task(priority: .high) {
//            var snapshot = DataSnapshot()
//            snapshot.appendSections(UISection.allCases)
//            snapshot.appendItems(
//                Categories.all.map(UIItem.category),
////                viewModel.categories.map(UIItem.category),
//                toSection: .category
//            )
////            snapshot.appendItems(
////                viewModel.topHeadlines.map(UIItem.topHeadline),
////                toSection: .topHeadline
////            )
////            snapshot.appendItems(
////                viewModel.recommended.map(UIItem.recommended),
////                toSection: .recommended
////            )
////            dataSource.supplementaryViewProvider = makeSupplementaryProvider(viewModel)
//            dataSource.apply(snapshot)
//        }
//    }
//    
//    func makeDataSource() -> DataSource {
//        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.identifier, for: indexPath)
//            
//            switch item {
//            case let .browser(model):
//                break
//            case let .discover(model):
//                break
//            case let .searchBar(model):
//                if let searchBarCell = cell as? SearchBarViewCell {
//                    searchBarCell.configure(searchBar: model)
//                    searchBarCell.delegate = self  
//                }
//            case let .category(model):
//                (cell as? CategoriesViewCell)?.configure(category: model)
//            case let .topHeadline(model):
//                (cell as? TopHeadlinesViewCell)?.configure(topHeadlines: model)
//            //case let .recommended(model):
//            //  break
//            }
//            
//            return cell
//        }
//        
//        Task(priority: .high) {
//            var snapshot = DataSnapshot()
//            snapshot.appendSections(UISection.allCases)
//            snapshot.appendItems(
//                browseArray.map(UIItem.browser),
//                toSection: .browser
//            )
//            snapshot.appendItems(
//                discoverArray.map(UIItem.discover),
//                toSection: .discover
//            )
//            snapshot.appendItems(
//                searchBarArray.map(UIItem.searchBar),
//                toSection: .searchBar
//            )
//            snapshot.appendItems(
//                categoriesArray.map(UIItem.category),
//                toSection: .category
//            )
//            print("topHeadlinesArray", topHeadlinesArray)
//            snapshot.appendItems(
//                topHeadlinesArray.map(UIItem.topHeadline),
//                toSection: .topHeadline
//            )
//            dataSource.apply(snapshot)
//        }
//        
//        return dataSource
//    }
//    
////    func makeSupplementaryProvider(_ viewModel: HomeViewModel) -> DataSource.SupplementaryViewProvider {
////        { collectionView, kind, indexPath in
////            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
////            switch Section(rawValue: indexPath.section) {
////            case .recommended:
////                let header = collectionView.dequeueReusableSupplementaryView(
////                    ofKind: kind,
////                    withReuseIdentifier: "headerIdentifier",
////                    for: indexPath
////                ) as? CollectionHeader
////                header?.configure(viewModel.header)
////                return header
////            default: return nil
////            }
////        }
////    }
//}
//
//final class CollectionHeader: UICollectionReusableView {
//    func configure(_ model: HomeViewModel.Header) {
//        
//    }
//}
//
// 
//// MARK: - SwiftUI Preview for UIKit View
//struct HomeViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        HomeViewWrapper()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
//
//struct HomeViewWrapper: UIViewRepresentable {
//  
//    func makeUIView(context: Context) -> UIView {
//        let homeViewController = HomeViewController(presenter: HomeViewPresenterImpl(networking: NewsRepository.shared, router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())))
//        
//        return homeViewController.view
//    }
//    
//    func updateUIView(_ uiView: UIView, context: Context) {
//        
//    }
//}
