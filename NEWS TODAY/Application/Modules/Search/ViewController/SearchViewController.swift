//
//  SearchViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 05.11.2024.
//

import UIKit
import SwiftUI
import Repository

protocol SearchViewPresenter: AnyObject {
}

final class SearchViewController: UIViewController {
    
    //MARK: - Properties
    private let presenter: SearchViewPresenter
    private var news: [Article] = [
        Article(category: "News", header: "Headline 1", imageName: "onb1", author: "Author 1", article: "Content 1"),
        Article(category: "News", header: "Headline 2", imageName: "onb2", author: "Author 2", article: "Content 2")
    ]
    
    //MARK: - UI Components
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.reuseID)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.rowHeight = 105
        return table
    }()
    
    //MARK: - Init
    init(presenter: SearchViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setup Methods
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - SearchViewController + UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.reuseID, for: indexPath) as? BookmarkCell else {
            fatalError("Unable to dequeue BookmarkCell")
        }
        cell.set(info: news[indexPath.row])
        return cell
    }
}

//MARK: - SearchViewController + UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Логика обработки выбора ячейки
    }
}

//MARK: - SearchViewController + UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Логика фильтрации или поиска при изменении текста
    }
}

extension SearchViewController: SearchViewDelegate {
    
}



struct SearchViewControllerPreview: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let searchViewController = SearchViewController(
            presenter: SearchViewPresenterImpl(networking: NewsRepository.shared, router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController()))
        )
        return searchViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct SearchViewControllerPreview_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewControllerPreview()
            .previewLayout(.sizeThatFits)
    }
}

