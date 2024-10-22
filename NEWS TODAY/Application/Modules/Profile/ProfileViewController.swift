//
//  ProfileViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import UIKit

protocol ProfileViewPresenter: AnyObject {}

final class ProfileViewController: UIViewController {
  
    //MARK: - Properties
    private let presenter: ProfileViewPresenter
    
    //MARK: - Init
    init(presenter: ProfileViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

//MARK: - ProfileViewController + ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {}
