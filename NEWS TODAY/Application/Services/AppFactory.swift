//
//  AppFactory.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import Repository
import Models

enum Screens { case home, categories, detail, profile, bookmarks, onboarding, termsAndConditions, languageSelection, search }

protocol MainFactory {
    
}

class MainRouter {
    let factory: MainFactory
    let parent: AppRouter
    let navigationController: UINavigationController
    
    init(
        factory: MainFactory,
        parent: AppRouter,
        navigationController: UINavigationController
    ) {
        self.factory = factory
        self.parent = parent
        self.navigationController = navigationController
    }
    
    
}

protocol AppFactory {
    func makeScreen(_ screen: Screens, _ router: AppRouter, articles: [Article]?, selectedIndex: Int?) -> UIViewController
    func makeTabBar(_ router: AppRouter) -> UITabBarController
}

final class AppFactoryImpl {
    
    // MARK: - Properties
    private let networking: NewsRepository
    
    // MARK: - Init
    init() {
        self.networking = NewsRepository.shared
    }
    
    //MARK: - Methods
    func makeAppRouter(_ navigationController: UINavigationController) -> AppRouter {
        AppRouterImpl(factory: self,navigation: navigationController)
    }
}

// MARK: - AppFactoryImpl + AppFactory
extension AppFactoryImpl: AppFactory {
    func makeScreen(
        _ screen: Screens,
        _ router: AppRouter,
        articles: [Article]?,
        selectedIndex: Int?
    ) -> UIViewController {
        
        switch screen {
        case .home:
            let presenter = MainViewPresenterImpl(
                networking: networking,
                router: router
            )
            
            let collectionView = UICollectionView(
                           frame: .zero,
                           collectionViewLayout: MainViewCompLayout().createLayout()
                       )
            
            let viewController = MainViewController(
                presenter: presenter,
                dataSource: MainViewDataSourceImpl(collectionView: collectionView),
                collectionView: collectionView,
                headerView: HeaderView()
            )
            
            presenter.view = viewController
            viewController.tabBarItem = makeTabItem(.home)
            return viewController
            
        case .categories:
            let presenter = CategoriesViewPresenterImpl(
                networking: networking,
                router: router
            )
            let viewController = CategoriesViewController(presenter: presenter)
            presenter.view = viewController
            viewController.tabBarItem = makeTabItem(.categories)
            return viewController
            
        case .detail:
            guard let articles = articles,
                  let selectedIndex = selectedIndex else {
                fatalError("Articles and selectedIndex must be provided for the detail screen")
            }
            
            let presenter = DetailViewPresenterImpl(
                networking: networking,
                router: router,
                articles: articles,
                selectedIndex: selectedIndex
            )
            let viewController = DetailViewController(
                presenter: presenter,
                detailView: DetailViewImpl()
            )
            presenter.view = viewController
            return viewController

            
        case .profile:
            let presenter = ProfileViewPresenterImpl(
                networking: networking,
                router: router
            )
            let viewController = ProfileViewController(presenter: presenter, profileView: ProfileViewImpl())
            presenter.view = viewController
            viewController.tabBarItem = makeTabItem(.profile)
            return viewController
            
        case .bookmarks:
            let presenter = BookmarksViewPresenterImpl(
                networking: networking,
                router: router
            )
            let viewController = BookmarksViewController(presenter: presenter)
            presenter.view = viewController
            viewController.tabBarItem = makeTabItem(.bookmarks)
            return viewController
            
        case .onboarding:
            let presenter = OnboardingViewPresenterImpl(
                networking: networking,
                router: router
            )
            let viewController = OnboardingViewController(presenter: presenter)
            presenter.view = viewController
            return viewController
            
        case .termsAndConditions:
            return TermsViewController(router: router)
            
        case .languageSelection:
            let presenter = ProfileViewPresenterImpl(
                networking: networking,
                router: router
            )
            let viewController = LanguageSelectionViewController(presenter: presenter)
            presenter.view = viewController
            return viewController
            
        case .search:
            let presenter = SearchViewPresenterImpl(
                networking: networking,
                router: router,
                articles: articles ?? []
            )
            
            let viewController = SearchViewController(presenter: presenter)
            presenter.view = viewController
            return viewController
        }
    }
    
    // MARK: - Create TabBar
    func makeTabBar(_ router: AppRouter) -> UITabBarController {
        let tabBarController = MainTabBarController()
        
        let homeModule = makeScreen(.home, router)
        let categoriesModule = makeScreen(.categories, router)
        let bookmarksModule = makeScreen(.bookmarks, router)
        let profileModule = makeScreen(.profile, router)
        
        let homeNavController = UINavigationController(rootViewController: homeModule)
        tabBarController.viewControllers = [
            homeNavController,
            categoriesModule,
            bookmarksModule ,
            profileModule
        ]
        return tabBarController
    }
    
    // MARK: - create TabBarItems
    enum TabType {
        case home
        case categories
        case bookmarks
        case profile
        
        var imageNormal: UIImage? {
            switch self {
            case .home: return UIImage.home
            case .categories: return UIImage.categories
            case .bookmarks: return UIImage.bookmarks
            case .profile: return UIImage.profile
            }
        }
        
        let viewController = HomeViewController(presenter: presenter)
        presenter.view = viewController
        viewController.tabBarItem = makeTabItem(.home)
        
        return viewController
    }
    
    enum TabType: String {
        case home
        case categories
        case bookmarks
        case profile
        
        var title: String { rawValue.uppercased() }
        
        var imageNormal: UIImage? {
            switch self {
            case .home: UIImage(systemName: "house")
            case .categories: UIImage(systemName: "square.grid.2x2")
            case .bookmarks: UIImage(systemName: "bookmark")
            case .profile: UIImage(systemName: "person")
            }
        }
        
        var imageSelected: UIImage? {
            switch self {
            case .home: UIImage(systemName: "house.fill")
            case .categories: UIImage(systemName: "square.grid.2x2.fill")
            case .bookmarks: UIImage(systemName: "bookmark.fill")
            case .profile: UIImage(systemName: "person.fill")
            }
        }
    }
    
    func makeTabItem(_ type: TabType) -> UITabBarItem {
        UITabBarItem(title: type.title, image: type.imageNormal, selectedImage: type.imageSelected)
    }
    
    func makeCategoriesModule(_ router: AppRouter) -> UIViewController {
        let presenter = CategoriesViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = CategoriesViewController(presenter: presenter)
        presenter.view = viewController
        
        viewController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "square.grid.2x2"),
            selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        
        return viewController
    }
    
    func makeBookmarksModule(_ router: AppRouter) -> UIViewController {
        let presenter = BookmarksViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = BookmarksViewController(presenter: presenter)
        presenter.view = viewController
        
        viewController.tabBarItem = UITabBarItem(
            title: "Bookmarks",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill"))
        
        return viewController
    }
    
    func makeProfileModule(_ router: AppRouter) -> UIViewController {
        let presenter = ProfileViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = ProfileViewController(
            presenter: presenter,
            profileView: ProfileViewImpl()
        )
        presenter.view = viewController
        
        viewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
        
        return viewController
    }
    
    func makeOnboardingModule(_ router: AppRouter) -> UIViewController {
        
        let presenter = OnboardingViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = OnboardingViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
    
    func makeDetailModule(_ router: AppRouter) -> UIViewController {
        let presenter = DetailViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = DetailViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
    
    //MARK: - Create screens
   func makeTermsAndConditionsScreen(_ router: AppRouter) -> UIViewController {
        let viewController = TermsViewController(
            router: router)
        return viewController
    }
}

extension AppFactory {
    func makeScreen(_ screen: Screens, _ router: AppRouter) -> UIViewController {
        return makeScreen(screen, router, articles: nil, selectedIndex: nil)
    }
}

