import UIKit
import Repository
import Models


protocol BookmarkViewDelegate: AnyObject {
    
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

    func didTapCell(at index: Int) {
        guard let article = news[safe: index] else { return }
        router.showDetailView(for: article)
    }
}
