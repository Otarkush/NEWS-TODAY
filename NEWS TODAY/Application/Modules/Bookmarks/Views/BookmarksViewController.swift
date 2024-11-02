//
//  BookmarksViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import UIKit

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
    private var titleLabelBig: UILabel {
        let label = UILabel()
        label.text = "Bookmarks"
        label.font = .InterSemiBold(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }
    
    private var titleLabelSmall: UILabel {
        let label = UILabel()
        label.text = "Saved articles to the library"
        label.font = .InterRegular(ofSize: 16)
        label.textColor = .greyPrimary
        label.numberOfLines = 1
        return label
    }
        
    private let emptyView = EmptyView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    //MARK: - Public Methods
    
    func updateEmptyViewVisibility() {
        emptyView.isHidden = presenter.newsCount() > 0
        }
    
    func configureTableView() {
        tableView.rowHeight = 96
        tableView.separatorStyle = .none
    }
    
    func setupViews() {
        [titleLabelBig, titleLabelSmall, tableView, emptyView].forEach {view.addSubview($0) }
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


