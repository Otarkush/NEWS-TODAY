//
//  HomeViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

protocol HomeViewPresenter: AnyObject {}

final class HomeViewController: UIViewController {
  
    //MARK: - Properties
    private let presenter: HomeViewPresenter
    
    //MARK: - Init
    init(presenter: HomeViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

//MARK: - HomeViewController + HomeViewDelegate
extension HomeViewController: HomeViewDelegate {}
