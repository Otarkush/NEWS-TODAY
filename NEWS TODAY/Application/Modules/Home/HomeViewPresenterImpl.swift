//
//  HomeViewPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation

protocol HomeViewDelegate: AnyObject {}

final class HomeViewPresenterImpl  {
  
    //MARK: - Properties
    weak var view: HomeViewDelegate?
    private let networking: AppNetworking
    private let router: AppRouter
  
    
    //MARK: - Init
    init(networking: AppNetworking,
         router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - HomeViewPresenterImpl + HomeViewPresenter
extension HomeViewPresenterImpl: HomeViewPresenter {}