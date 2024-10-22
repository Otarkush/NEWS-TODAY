//
//  BookmarksViewDelegate.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import Foundation

protocol BookmarksViewDelegate: AnyObject {}

final class BookmarksViewPresenterImpl  {
  
    //MARK: - Properties
    weak var view: BookmarksViewDelegate?
    private let networking: AppNetworking
    private let router: AppRouter
  
    //MARK: - Init
    init(networking: AppNetworking,
         router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - BookmarksViewPresenterImpl + BookmarksViewPresenter
extension BookmarksViewPresenterImpl: BookmarksViewPresenter {}
