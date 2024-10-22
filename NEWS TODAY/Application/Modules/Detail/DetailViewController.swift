//
//  DetailViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

protocol DetailViewPresenter: AnyObject {}

final class DetailViewController: UIViewController {
   
    //MARK: - Properties
    private let presenter: DetailViewPresenter

    //MARK: - Init
    init(presenter: DetailViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - DetailViewController + DetailViewDelegate
extension DetailViewController: DetailViewDelegate {}
