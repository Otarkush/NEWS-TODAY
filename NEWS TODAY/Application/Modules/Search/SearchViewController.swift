//
//  SearchViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 05.11.2024.
//

import UIKit

protocol SearchViewPresenter: AnyObject {
}

final class SearchViewController: UIViewController {
    weak var presenter: SearchViewPresenter?
}

//MARK: - SearchViewController + SearchViewDelegate
extension SearchViewController: SearchViewDelegate  {
    
}
