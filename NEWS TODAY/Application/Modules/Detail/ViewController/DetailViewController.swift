//
//  DetailViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI
import Models

protocol DetailViewPresenter: AnyObject {
    func show(data: DetailData) -> String
    func didTap(button interaction: DetailViewInteraction)
    func viewDidLoad()
}

final class DetailViewController: UIViewController {
   
    // MARK: - Properties
    private let presenter: DetailViewPresenter
    private let detailView: DetailView

    // MARK: - Init
    init(
        presenter: DetailViewPresenter,
        detailView: DetailView
    ) {
        self.presenter = presenter
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        presenter.viewDidLoad()  
        setupActions()
    }
    
    override func loadView() {
        view = detailView
    }
    
    private func setupActions() {
        detailView.backButton.addAction(
            UIAction { [weak self] _ in
                self?.backButtonTapped()
            },
            for: .touchUpInside
        )
    }
    
    private func backButtonTapped() {
        presenter.didTap(button: .back)
    }
}

// MARK: - DetailViewController + DetailViewDelegate
extension DetailViewController: DetailViewDelegate {
    func updateUI(viewModel: Article) {
            if let imageUrl = viewModel.urlToImage, let imageData = try? Data(contentsOf: imageUrl) {
                detailView.imageView.image = UIImage(data: imageData)
            } else {
                detailView.imageView.image = UIImage(named: "onb2") 
            }
            
            detailView.authorNameLabel.text = viewModel.author ?? "Unknown author"
            detailView.newsHeaderLabel.text = viewModel.title
            detailView.categoryLabel.text = viewModel.source.name
            detailView.detailsTextView.text = viewModel.content ?? "No content available"
        }
}

//MARK: - ViewModel experiment
struct DetailViewModel {
    let category: String
    let header: String
    let imageName: String
    let author: String
    let article: String
}
