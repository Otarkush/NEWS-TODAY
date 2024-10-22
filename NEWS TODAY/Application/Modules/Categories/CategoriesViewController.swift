//
//  CategoriesViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import UIKit

protocol CategoriesViewPresenter: AnyObject {}

final class CategoriesViewController: UIViewController {
  
    //MARK: - Properties
    private let presenter: CategoriesViewPresenter
    
    //MARK: - Init
    init(presenter: CategoriesViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

//MARK: - CategoriesViewController + CategoriesViewDelegate
extension CategoriesViewController: CategoriesViewDelegate {}
