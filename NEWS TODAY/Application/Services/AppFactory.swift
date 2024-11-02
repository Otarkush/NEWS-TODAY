//
//  AppFactory.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import NetworkManager
import PersistenceManager
import Repository

enum Screens {case home, categories, detail, profile, bookmarks, onboarding, termsAndConditions, languageSelection}

protocol AppFactory {
    func makeScreen(_ screen: Screens, _ router: AppRouter) -> UIViewController
    func makeTabBar(_ router: AppRouter) -> UITabBarController 
}

final class AppFactoryImpl  {
    
    //MARK: - Properties
    private let networking: AppNetworking
    
    //MARK: - Init
    init() {
        self.networking = NetworkingManagerImpl()
    }
    
    //MARK: - Methods
    static func makeAppRouter(_ navigationController: UINavigationController,
                              _ window: UIWindow?) -> AppRouter {
        
        AppRouterImpl(
            factory: AppFactoryImpl(),
            navigation: navigationController,
            window: window)
    }
}

//MARK: - AppFactoryImpl + AppFactory
extension AppFactoryImpl: AppFactory {
    func makeScreen(_ screen: Screens, _ router: any AppRouter) -> UIViewController {
        
        switch screen {
        case .home:
            let presenter = HomeViewPresenterImpl(
                networking: networking,
                router: router)
            
            let viewController = HomeViewController(presenter: presenter)
            presenter.view = viewController
            viewController.tabBarItem = makeTabItem(.home)
            return viewController
            
        case .categories:
            let presenter = CategoriesViewPresenterImpl(
                networking: networking,
                router: router)

            let viewController = CategoriesViewController(presenter: presenter)
            presenter.view = viewController
            viewController.tabBarItem = makeTabItem(.categories)
            return viewController
            
        case .detail:
            let presenter = DetailViewPresenterImpl(
                networking: networking,
                router: router)
            
            let viewController = DetailViewController(presenter: presenter, detailView: DetailViewImpl())
            presenter.view = viewController
            return viewController
            
        case .profile:
            let presenter = ProfileViewPresenterImpl(
                networking: networking,
                router: router)
            
            let viewController = ProfileViewController(presenter: presenter, profileView: ProfileViewImpl())
            presenter.view = viewController
            viewController.tabBarItem = makeTabItem(.profile)
            return viewController
            
        case .bookmarks:
            let presenter = BookmarksViewPresenterImpl(
                networking: networking,
                router: router)
            
            let viewController = BookmarksViewController(presenter: presenter)
            presenter.view = viewController
            viewController.tabBarItem = makeTabItem(.bookmarks)
            return viewController
            
        case .onboarding:
            let presenter = OnboardingViewPresenterImpl(
                networking: networking,
                router: router)
            
            let viewController = OnboardingViewController(presenter: presenter)
            presenter.view = viewController
            return viewController
            
        case .termsAndConditions:
            let viewController = TermsViewController(router: router)
            return viewController
            
        case .languageSelection:
            let presenter = ProfileViewPresenterImpl(
                networking: networking,
                router: router)
            
            let viewController = LanguageSelectionViewController(presenter: presenter)
            presenter.view = viewController
            return viewController
        }
    }
    
    //MARK: - Create TabBar
    func makeTabBar(_ router: AppRouter) -> UITabBarController {
        let tabBarController = MainTabBarController()
        
        let homeModule = makeScreen(.home, router)
        let categoriesModule = makeScreen(.categories, router)
        let bookmarksModule = makeScreen(.bookmarks, router)
        let profileModule = makeScreen(.profile, router)
        
        tabBarController.viewControllers = [homeModule, categoriesModule,bookmarksModule ,profileModule]
        
        return tabBarController
    }
    
    //MARK: - create TabBarItems
    enum TabType {
        case home
        case categories
        case bookmarks
        case profile
        
        var imageNormal: UIImage? {
            switch self {
            case .home: UIImage.home
            case .categories: UIImage.categories
            case .bookmarks: UIImage.bookmarks
            case .profile: UIImage.profile
            }
        }
        
        var imageSelected: UIImage? {
            switch self {
            case .home: UIImage.homeSelected
            case .categories: UIImage.categoriesSelected
            case .bookmarks: UIImage.bookmarksSelected
            case .profile: UIImage.profileSelected
            }
        }
    }
    
    func makeTabItem(_ type: TabType) -> UITabBarItem {
        UITabBarItem(title: nil, image: type.imageNormal, selectedImage: type.imageSelected)
    }
}
