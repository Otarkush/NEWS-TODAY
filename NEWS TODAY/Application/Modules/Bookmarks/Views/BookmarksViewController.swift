//
//  BookmarksViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import UIKit
import SwiftUI

protocol BookmarksViewPresenter: AnyObject {
    
    func newsCount() -> Int
    func didTapCell()
}

class BookmarksViewController: UIViewController {
  
    //MARK: - Properties
    
    private let tableView = UITableView()
    private let presenter: BookmarksViewPresenter
    
    //MARK: - Init
    init(presenter: BookmarksViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Components
    private lazy var table: UITableView = {
        let table = UITableView()
        table.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.reuseID)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private var titleLabelBig: UILabel = {
        let label = UILabel()
        label.text = "Bookmarks"
        label.font = .InterSemiBold(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabelSmall: UILabel = {
        let label = UILabel()
        label.text = "Saved articles to the library"
        label.font = .InterRegular(ofSize: 16)
        label.textColor = .greyPrimary
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let emptyView = EmptyView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    //MARK: - Public Methods
    
//    func updateEmptyViewVisibility() {
//        emptyView.isHidden = presenter.newsCount() > 0
//        }
    
    func setupViews() {
        [titleLabelBig, titleLabelSmall, tableView].forEach(view.addSubview)
    }
}

extension BookmarksViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabelBig.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            titleLabelBig.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            titleLabelSmall.leadingAnchor.constraint(equalTo: titleLabelBig.leadingAnchor),
            titleLabelSmall.topAnchor.constraint(equalTo: titleLabelBig.bottomAnchor, constant: 8),

            tableView.topAnchor.constraint(equalTo: titleLabelSmall.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            }
    }

//MARK: - BookmarksViewController + BookmarksViewDelegate
extension BookmarksViewController: BookmarkViewDelegate {
    
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.newsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.reuseID)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapCell()
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct BookmarksViewController_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingViewWrapper1()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct OnboardingViewWrapper1: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let onboardingViewController = OnboardingViewController(presenter: OnboardingViewPresenterImpl(networking: NetworkingManagerImpl(), router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())))
        
        return onboardingViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
