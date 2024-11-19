//
//  MainViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 18.11.2024.
//

import UIKit
import SwiftUI
import Models
import Repository

protocol MainViewPresenter: AnyObject {
    func viewDidLoad()
}

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let presenter: MainViewPresenter
    private var collectionView: UICollectionView!
    private var headerView: HeaderView!
    private var dataSource: MainViewDataSource!
    
    private var categoriesArray = [Category]()
    private var topHeadlinesArray = [Article]()
    
    // MARK: - Init
    init(presenter: MainViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataSource()
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        
        // Header View
        headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        // Collection View
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: MainViewCompLayout().createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: CategoriesViewCell.identifier)
        collectionView.register(TopHeadlinesViewCell.self, forCellWithReuseIdentifier: TopHeadlinesViewCell.identifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            // Header View Constraints
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150), // Высота для HeaderView
            
            // Collection View Constraints
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    private func setupDataSource() {
        dataSource = MainViewDataSource(collectionView: collectionView)
    }
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    func updateUI(categories: [Category], headlines: [Article]) {
        self.categoriesArray = categories
        self.topHeadlinesArray = headlines
        dataSource.updateSnapshot(categories: categoriesArray, topHeadlines: topHeadlinesArray)
    }
}


//MARK: - SwiftUi preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: MainViewController(presenter: MainViewPresenterImpl(networking: NewsRepository.shared, router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController()) )))
            
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

