//
//  DetailViewPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation

protocol DetailViewDelegate: AnyObject {}

final class DetailViewPresenterImpl  {
    
    //MARK: - Properties
    weak var view: DetailViewDelegate?
    private let networking: AppNetworking
    private let router: AppRouter
    
    //MARK: - Init
    init(networking: AppNetworking, router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - DetailViewPresenterImpl + DetailViewPresenter
extension DetailViewPresenterImpl: DetailViewPresenter {}
