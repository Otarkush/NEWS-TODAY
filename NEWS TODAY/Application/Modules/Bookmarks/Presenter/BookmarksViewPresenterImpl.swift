import Foundation
import UIKit

protocol BookmarksViewDelegate: AnyObject {
    var bookmarkCount: Int { get }
    func getBookmark(at index: Int) -> Article
    func viewDidLoad()
    func didEditingDelete(at indexPath: IndexPath)
}

final class BookmarksViewPresenterImpl: BookmarksViewDelegate {
    
    //MARK: - Properties
    weak var BookmarksViewControllerProtocol: BookmarksViewDelegate?
    private let networking: AppNetworking
    private let router: AppRouter
    
    var bookmarks: [Article] = []
    
    //MARK: - Init
    init(networking: AppNetworking,
         router: AppRouter) {
        self.networking = networking
        self.router = router
    }
    
    var bookmarkCount: Int {
        return bookmarks.count
    }
    
    func getBookmark(at index: Int) -> Article {
        return getBookmark[index]
    }
    
    func viewDidLoad() {
        BookmarksViewPresenter?.reloadTableView()
    }
    
    func didEditingDelete(at indexPath: IndexPath) {
        self.bookmarks.remove(at: indexPath.row)
        self.BookmarksViewControllerProtocol?.reloadTableView()
    }
  
  
}

//MARK: - BookmarksViewPresenterImpl + BookmarksViewPresenter
//extension BookmarksViewPresenterImpl: BookmarksViewPresenter? {}
