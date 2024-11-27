//
//  SearchViewPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 05.11.2024.
//

import Foundation
import Repository
import Models

protocol SearchViewDelegate: AnyObject {
    
}

final class SearchViewPresenterImpl {
    
    //MARK: - Properties
    weak var view: SearchViewDelegate?
    private let networking: NewsRepository
    private let router: AppRouter
    private let articles: [Article]
    
    //MARK: - Init
    init(networking: NewsRepository,
         router: AppRouter,
         articles: [Article]
    ) {
        self.networking = networking
        self.router = router
        self.articles = articles 
    }
}

extension SearchViewPresenterImpl: SearchViewPresenter {
    
    func didSelectArticle(at index: Int) {
        guard let article = articles[safe: index] else { return }
        router.showDetailView(for: article)
    }
    
    
    func articleForRow(at index: Int) -> Models.Article? {
        articles[safe: index]
    }

    func newsCount() -> Int { articles.count }
}
