//
//  MainViewController.swift
//  NEWS TODAY
//
//  Created by Aria Arisova on 22.10.2024.
//  Modified by Daniil Murzin

import UIKit
import SwiftUI
import Models
import Repository

enum MainVCInteraction {
    case searchButton(String)
    case searchFieldDidChange(String)
}

protocol MainViewPresenter: AnyObject {
    func viewDidLoad()
    func didTap(action: MainVCInteraction)
}


final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let presenter: MainViewPresenter
    private let collectionView: UICollectionView
    private let headerView: HeaderView
    private let dataSource: any MainViewDataSource
    
    private var categoriesArray = [Category]()
    private var topHeadlinesArray = [Article]()
    
    // MARK: - Init
    init(
        presenter: MainViewPresenter,
        dataSource: any MainViewDataSource,
        collectionView: UICollectionView,
        headerView: HeaderView
    ) {
        self.presenter = presenter
        self.dataSource = dataSource
        self.collectionView = collectionView
        self.headerView = headerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUI()
        setupButtonActions()
        presenter.viewDidLoad()
        setupConstraints()
    }
    
    // MARK: - private funcs
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: CategoriesViewCell.identifier)
        collectionView.register(TopHeadlinesViewCell.self, forCellWithReuseIdentifier: TopHeadlinesViewCell.identifier)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(collectionView)
    }
    
    // MARK: - Button Actions
    private func setupButtonActions() {
        headerView.searchButton.addAction(
            UIAction { [weak self] _ in
                self?.searchButtonTapped()
            },
            for: .touchUpInside
        )
        
        headerView.searchTextField.addAction(
              UIAction { [weak self] _ in
                  self?.searchTextFieldDidReturn()
              },
              for: .editingDidEndOnExit
          )
    }
    
    private func searchButtonTapped() {
        guard let query = headerView.searchTextField.text, !query.isEmpty else { return }
        presenter.didTap(action: .searchButton(query))
    }
    
    private func searchTextFieldDidReturn() {
        guard let query = headerView.searchTextField.text, !query.isEmpty else { return }
        
        presenter.didTap(action: .searchFieldDidChange(query))
    }
}

// MARK: - MainViewController + MainViewDelegate
extension MainViewController: MainViewDelegate {
    func updateUI(
        categories: [Category],
        headlines: [Article]
    ) {
        self.categoriesArray = categories
        self.topHeadlinesArray = headlines
        dataSource.updateSnapshot(
            categories: categoriesArray,
            topHeadlines: topHeadlinesArray)
    }
}

//MARK: - MainViewController + setupConstraints
extension MainViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: - SwiftUi preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> UIViewController {
            let collectionView = UICollectionView(
                           frame: .zero,
                           collectionViewLayout: MainViewCompLayout().createLayout()
                       )
                       collectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: CategoriesViewCell.identifier)
                       collectionView.register(TopHeadlinesViewCell.self, forCellWithReuseIdentifier: TopHeadlinesViewCell.identifier)
            
            return UINavigationController(
                rootViewController: MainViewController(
                    presenter: MainViewPresenterImpl(
                        networking: NewsRepository.shared,
                        router: AppRouterImpl(
                            factory: AppFactoryImpl(),
                            navigation: UINavigationController())),
                    dataSource: MainViewDataSourceImpl(collectionView: collectionView),
                    collectionView: collectionView,
                    headerView: HeaderView()))
            
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
        
        
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

