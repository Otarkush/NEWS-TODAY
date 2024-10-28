//
//  DetailViewPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation

enum DetailViewInteraction {
    case back
    case favorite
    case share
}

enum DetailData {
    case category
    case header
    case article
    case author
    case image
}

protocol DetailViewDelegate: AnyObject {
    func updateUI(viewModel: DetailViewModel)
}

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
extension DetailViewPresenterImpl: DetailViewPresenter {
    func show(data: DetailData) -> String {
        switch data {
        case .article:
            Drawings.detailsText
        case .category:
            Drawings.categoryText
        case .header:
            Drawings.newsHeaderText
        case .author:
            Drawings.authorNameText
        case .image:
            "Capital"
        }
    }
    
    func didTap(button interaction: DetailViewInteraction) {
        switch interaction {
        case .back:
            router.back()
        case .favorite:
            router.popToRoot()
        case .share:
            router.popToRoot()
        }
    }
    
    func viewDidLoad() {
        view?.updateUI(viewModel:
                        DetailViewModel(
                            category: show(data: .category),
                            header: show(data: .header),
                            imageName: show(data: .image),
                            author: show(data: .author),
                            article: show(data: .article)
                        )
        )
    }
}
