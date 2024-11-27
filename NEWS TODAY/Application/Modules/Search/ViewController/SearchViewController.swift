//
//  SearchViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 05.11.2024.
//

import UIKit
import SwiftUI
import Repository
import Models

protocol SearchViewPresenter: AnyObject {
    func newsCount() -> Int
    func articleForRow(at index: Int) -> Article?
    func didSelectArticle(at index: Int)
}

final class SearchViewController: UIViewController {
    
    //MARK: - Properties
    private let presenter: SearchViewPresenter
    
    //MARK: - UI Components
    private let searchBar = HeaderView()
    
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
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 150),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - SearchViewController + UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
   
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int {
        return presenter.newsCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookmarkCell.reuseID,
            for: indexPath
        ) as? BookmarkCell else {
            fatalError("Unable to dequeue BookmarkCell")
        }
        
        guard let article = presenter.articleForRow(at: indexPath.row) else {
            assertionFailure("Presenter returned nil for index \(indexPath.row)")
            return cell
        }
        
        cell.set(info: article)
        return cell
    }
}

//MARK: - SearchViewController + UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.didSelectArticle(at: indexPath.row)
    }
}

extension SearchViewController: SearchViewDelegate {}

//MARK: - SwiftUI Preview
struct SearchViewControllerPreview: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let searchViewController = SearchViewController(
            presenter: SearchViewPresenterImpl(networking: NewsRepository.shared, router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController()), articles: [])
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

