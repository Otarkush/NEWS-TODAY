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
    
    // MARK: - Methods
    static func makeAppRouter(_ navigationController: UINavigationController,
                              _ window: UIWindow?) -> AppRouter {
        
        AppRouterImpl(
            factory: AppFactoryImpl(),
            navigation: navigationController,
            window: window
        )
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
            let viewController = MainViewController(presenter: presenter)
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
            guard let articles = articles, let selectedIndex = selectedIndex else {
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
                router: router
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
        
        tabBarController.viewControllers = [homeModule, categoriesModule, bookmarksModule, profileModule]
        
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
        
        var imageSelected: UIImage? {
            switch self {
            case .home: return UIImage.homeSelected
            case .categories: return UIImage.categoriesSelected
            case .bookmarks: return UIImage.bookmarksSelected
            case .profile: return UIImage.profileSelected
            }
        }
    }
    
    func makeTabItem(_ type: TabType) -> UITabBarItem {
        return UITabBarItem(title: nil, image: type.imageNormal, selectedImage: type.imageSelected)
    }
}

extension AppFactory {
    func makeScreen(_ screen: Screens, _ router: AppRouter) -> UIViewController {
        return makeScreen(screen, router, articles: nil, selectedIndex: nil)
    }
}

