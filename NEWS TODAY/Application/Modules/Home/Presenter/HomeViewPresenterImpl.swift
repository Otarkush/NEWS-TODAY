//
//  HomeViewPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation
import Models
import Repository

protocol HomeViewDelegate: AnyObject {
    func updateUIForCategories(with categories: [Category])
    func updateUIForNewsByCategory(with news: [News])
    func updateUIForRecommendedNews(with news: [News])
}

final class HomeViewPresenterImpl  {
  
    //MARK: - Properties
    weak var view: HomeViewDelegate?
    private let networking: NewsRepository
    private let router: AppRouter
  
    
    //MARK: - Init
    init(networking: NewsRepository,
         router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - HomeViewPresenterImpl + HomeViewPresenter
extension HomeViewPresenterImpl: HomeViewPresenter {
    
    func fetchCategories() -> [Category] {
        Categories.all
    }
    
    func viewDidLoad() {
        view?.updateUIForCategories(with: fetchCategories())
        view?.updateUIForNewsByCategory(with: [])
        view?.updateUIForRecommendedNews(with: [])
    }
}
