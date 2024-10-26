//
//  DetailViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

protocol DetailViewPresenter: AnyObject {}

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
    }
    
    override func loadView() {
        view = detailView
    }
}

//MARK: - DetailViewController + DetailViewDelegate
extension DetailViewController: DetailViewDelegate {}

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
