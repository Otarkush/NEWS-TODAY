import UIKit
import Repository
import Models

protocol BookmarkViewDelegate: AnyObject {
    
}

final class BookmarksViewPresenterImpl {
    
    //MARK: - Properties
    
    private var news: [Article] = .init()
    private let networking: AppNetworking
    private let router: AppRouter
    weak var view: BookmarkViewDelegate?
    
    //MARK: - Init
    init(networking: AppNetworking,
         router: AppRouter) {
        self.networking = networking
        self.router = router
        Task { await fetchArticles() }
    }
    
    func fetchArticles() async {
        let result = await NewsRepository.shared.loadArticles()
        
        switch result {
        case .success(let articles): self.news = articles
            print("Загруженные статьи: \(articles)")
        case .failure(let error):
            print("Ошибка при загрузке статей: \(error)")
        }
    }
        
    }
    
    //    var bookmarkCount: Int {
    //        return bookmarks.count
    //    }
    //
    //    func getBookmark(at index: Int) -> Article {
    //        return getBookmark[index]
    //    }
    //
    //    func viewDidLoad() {
    //        BookmarksViewPresenterImpl.reloadTableView()
    //    }
    //
    //    func didEditingDelete(at indexPath: IndexPath) {
    //        self.bookmarks.remove(at: indexPath.row)
    //        self.BookmarksViewPresenterProtocol?.reloadTableView()
    //    }
    //
    //
    //}

//MARK: - BookmarksViewPresenterImpl + BookmarksViewPresenter
extension BookmarksViewPresenterImpl: BookmarksViewPresenter {
    func newsCount() -> Int {
        news.count
    }
    
    func didTapCell() {
        router.showDetailView()
    }
    
        
 
}
