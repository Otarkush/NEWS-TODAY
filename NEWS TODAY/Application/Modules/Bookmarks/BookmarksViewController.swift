//
//  BookmarksViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import UIKit

protocol BookmarksViewPresenter: AnyObject {}

final class BookmarksViewController: UIViewController {
  
    //MARK: - Properties
    private let presenter: BookmarksViewPresenter
    
    //MARK: - Init
    init(presenter: BookmarksViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

//MARK: - BookmarksViewController + BookmarksViewDelegate
extension BookmarksViewController: BookmarksViewDelegate {}
