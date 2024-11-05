//
//  DetailViewPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation
import Repository


enum DetailViewInteraction {
    case back
    case favorite
    case share
}

enum DetailData {
    case category
    case header
    case article
    case author
    case image
}

protocol DetailViewDelegate: AnyObject {
    func updateUI(viewModel: Article)
}

final class DetailViewPresenterImpl {
    
    // MARK: - Properties
    weak var view: DetailViewDelegate?
    private let networking: NewsRepository
    private let router: AppRouter
    private let articles: [Article]
    private var selectedIndex: Int
    
    // MARK: - Init
    init(networking: NewsRepository, router: AppRouter, articles: [Article], selectedIndex: Int) {
        self.networking = networking
        self.router = router
        self.articles = articles
        self.selectedIndex = selectedIndex
    }
    
    private func currentArticle() -> Article {
        return articles[selectedIndex]
    }
}

// MARK: - DetailViewPresenterImpl + DetailViewPresenter
extension DetailViewPresenterImpl: DetailViewPresenter {
    func viewDidLoad() {
        view?.updateUI(viewModel: currentArticle())
    }
    
    func show(data: DetailData) -> String {
        let article = currentArticle()
        switch data {
        case .article:
            return article.article
        case .category:
            return article.category
        case .header:
            return article.header
        case .author:
            return article.author
        case .image:
            return article.imageName
        }
    }
    
    func didTap(button interaction: DetailViewInteraction) {
        switch interaction {
        case .back:
            router.back()
        case .favorite:
            print("Added to favorites")
        case .share:
            print("Shared article")
        }
    }
}

