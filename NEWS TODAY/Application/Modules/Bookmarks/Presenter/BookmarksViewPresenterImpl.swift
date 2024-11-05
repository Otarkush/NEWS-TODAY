import UIKit
import Repository


protocol BookmarkViewDelegate: AnyObject {
    
}

struct Article {
    let category: String
    let header: String
    let imageName: String
    let author: String
    let article: String
}

final class BookmarksViewPresenterImpl: BookmarksViewPresenter {
    private let networking: NewsRepository
    private let router: AppRouter
    private var news: [Article] = []
    weak var view: BookmarkViewDelegate?
    
    init(networking: NewsRepository, router: AppRouter) {
        self.networking = networking
        self.router = router
    }
    
    func fetchNews() {
        
    }

    func newsCount() -> Int {
        return news.count
    }

    func didTapCell(at index: Int, with articles: [Article]) {
        router.showDetailView(for: articles, selectedIndex: index)
    }
}
