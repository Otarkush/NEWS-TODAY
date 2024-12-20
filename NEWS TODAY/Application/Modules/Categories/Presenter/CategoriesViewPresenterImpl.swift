//
//  CategoriesViewDelegate.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import Foundation
import Repository


protocol CategoriesViewDelegate: AnyObject {
    func updateUI(with categories: [Category])
}

final class CategoriesViewPresenterImpl  {
  
    //MARK: - Properties
    weak var view: CategoriesViewDelegate?
    private let networking: NewsRepository
    private let router: AppRouter
  
    //MARK: - Init
    init(networking: NewsRepository,
         router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - CategoriesViewPresenterImpl + CategoriesViewPresenter
extension CategoriesViewPresenterImpl: CategoriesViewPresenter {
    
    func fetchCategories() -> [Category] {
        Categories.all
    }
    
    func viewDidLoad() {
        view?.updateUI(with: fetchCategories())
    }
}
