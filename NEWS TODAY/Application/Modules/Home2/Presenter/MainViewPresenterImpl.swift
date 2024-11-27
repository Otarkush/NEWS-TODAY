//
//  PresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 18.11.2024.
//

import Foundation
import Models
import Repository

protocol MainViewDelegate: AnyObject {
    func updateUI(categories: [Category], headlines: [Article])
}

final class MainViewPresenterImpl {
    
    // MARK: - Properties
    weak var view: MainViewDelegate?
    private let networking: NewsRepository
    private let router: AppRouter
    
    // MARK: - Init
    init(networking: NewsRepository, router: AppRouter) {
        self.networking = networking
        self.router = router
    }
    
    private func handleSearch(query: String) {
        
        Task {
            let result = await networking.search(query, size: 10)
            
            await MainActor.run {
                switch result {
                case .success(let articles):
                    router.showSearch(for: articles)
                    print("Found articles: \(articles.count)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

// MARK: - MainViewPresenter
extension MainViewPresenterImpl: MainViewPresenter {
//    func showDetailView(with article: Models.Article) {
//        <#code#>
//    }
    
    func didTap(action: MainVCInteraction) {
        switch action {
        case .searchButton(let query):
            handleSearch(query: query)
        case .searchFieldDidChange(let query):
            handleSearch(query: query)
        case .cellDidTap(_):
            break
        }
    }
    
    func viewDidLoad() {
        let categories = Categories.all
        
        Task {
            let result = await networking.search("Technology", size: 10)
            await MainActor.run {
                switch result {
                case .success(let articles):
                    view?.updateUI(categories: categories, headlines: articles)
                case .failure(let error):
                    print("Error fetching articles: \(error)")
                }
            }
        }
    }
}
