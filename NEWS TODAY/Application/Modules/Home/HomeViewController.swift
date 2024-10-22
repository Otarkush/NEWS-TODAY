//
//  HomeViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

protocol HomeViewPresenter: AnyObject {}

final class HomeViewController: UIViewController {

    private let presenter: HomeViewPresenter
    
    init(presenter: HomeViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - HomeViewController + HomeViewDelegate
extension HomeViewController: HomeViewDelegate {}
