//
//  ProfileViewDelegate.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import Foundation

protocol ProfileViewDelegate: AnyObject {}

final class ProfileViewPresenterImpl  {
  
    //MARK: - Properties
    weak var view: ProfileViewDelegate?
    private let networking: AppNetworking
    private let router: AppRouter
  
    //MARK: - Init
    init(networking: AppNetworking,
         router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - ProfileViewPresenterImpl + ProfileViewPresenter
extension ProfileViewPresenterImpl: ProfileViewPresenter {}
