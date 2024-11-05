//
//  SearchViewPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 05.11.2024.
//

import Foundation
import Repository
import Models

protocol SearchViewDelegate: AnyObject {
    
}

final class SearchViewPresenterImpl {
    
    //MARK: - Properties
    weak var view: SearchViewDelegate?
    private let networking: NewsRepository
    private let router: AppRouter
    
    //MARK: - Init
    init(networking: NewsRepository,
         router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

extension SearchViewPresenterImpl: SearchViewPresenter {
    
}
