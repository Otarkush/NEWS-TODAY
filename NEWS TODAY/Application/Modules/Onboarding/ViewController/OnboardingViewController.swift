//
//  OnboardingViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

protocol OnboardingViewPresenter: AnyObject {
    func createSlides() -> [OnboardingView]
    func setupUI()
    func setUpSlidesScrollView(slides: [OnboardingView])
}

final class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    private let presenter: OnboardingViewPresenter?
    private let onboardingView: OnboardingView
    private var slides = [OnboardingView]()
    
    //MARK: - UI
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .greyLighter
        pageControl.currentPageIndicatorTintColor = .purplePrimary
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    //MARK: - Init
    init(presenter: OnboardingViewPresenter?, view: OnboardingView) {
        self.presenter = presenter
        self.onboardingView = view
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
        view = onboardingView
    }
    override func viewDidDisappear(_ animated: Bool) {
        <#code#>
    }
}

//MARK: - OnboardingViewController + OnboardingViewDelegate
extension OnboardingViewController: OnboardingViewDelegate {
    func updateUI() {
        
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct OnbViewController_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingViewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct OnboardingViewWrapper: UIViewRepresentable {
  
    func makeUIView(context: Context) -> UIView {
        let onboardingViewController = OnboardingViewController(presenter: OnboardingViewPresenterImpl(networking: NetworkingManagerImpl(), router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())), view: OnboardingViewImpl())
        
        return onboardingViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
