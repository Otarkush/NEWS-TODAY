//
//  DetailViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

protocol DetailViewPresenter: AnyObject {
    func show(data: DetailData) -> String
    func didTap(button interaction: DetailViewInteraction)
    func viewDidLoad()
}

final class DetailViewController: UIViewController {
   
    //MARK: - Properties
    private let presenter: DetailViewPresenter
    private let detailView: DetailView

    //MARK: - Init
    init(
        presenter: DetailViewPresenter,
        detailView: DetailView
    ) {
        self.detailView = detailView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
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

//MARK: - DetailViewController + DetailViewDelegate
extension DetailViewController: DetailViewDelegate {
    func updateUI(viewModel: DetailViewModel) {
        detailView.imageView.image = UIImage(named: viewModel.imageName)
        detailView.authorNameLabel.text = viewModel.author
        detailView.newsHeaderLabel.text = viewModel.header
        detailView.categoryLabel.text = viewModel.category
        detailView.detailsTextView.text = viewModel.article
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct DetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        DetailViewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct DetailViewWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let profileViewController = DetailViewController(presenter: DetailViewPresenterImpl(networking: NetworkingManagerImpl(), router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())), detailView: DetailViewImpl())
        
        return profileViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
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
