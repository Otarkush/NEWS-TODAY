//
//  OnboardingViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

protocol OnboardingViewPresenter: AnyObject {
    func setupUI()
}

final class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Properties
    private let presenter: OnboardingViewPresenter?
    private var slides = [OnboardingView]()
    
    // MARK: - UI
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    internal let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .greyLighter
        pageControl.currentPageIndicatorTintColor = .purplePrimary
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    
    //MARK: - Init
    init(presenter: OnboardingViewPresenter?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupView()
        setupConstraints()
        slides = createSlides()
        setUpSlidesScrollView(slides: slides)
    }
    
    // MARK: - Methods
    private func setupView() {
        [scrollView, pageControl].forEach(view.addSubview)
    }
    
    func createSlides() -> [OnboardingView] {
        let slide1 = OnboardingViewImpl()
        slide1.setupSlideUI(
            image: "onb1",
            title: "First to know",
            description: "Save articles to your library",
            nextButtonTitle: "Next"
        )
        
        let slide2 = OnboardingViewImpl()
        slide2.setupSlideUI(
            image: "onb2",
            title: nil,
            description: "Save articles to your library",
            nextButtonTitle: "Next"
        )
        
        let slide3 = OnboardingViewImpl()
        slide3.setupSlideUI(
            image: "onb3",
            title: nil ,
            description: "Select your favorite topics" ,
            nextButtonTitle: "Get Started"
        )
        
        return [slide1, slide2, slide3]
    }
    
    func setUpSlidesScrollView(slides: [OnboardingView]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(
                x: view.frame.width * CGFloat(i),
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
            
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
         pageControl.currentPage = Int(pageIndex)
     }
}

//MARK: - OnboardingViewController + OnboardingViewDelegate
extension OnboardingViewController: OnboardingViewDelegate {
    func updateUI() {
        
    }
}

extension OnboardingViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 490),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
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
            let onboardingViewController = OnboardingViewController(presenter: OnboardingViewPresenterImpl(networking: NetworkingManagerImpl(), router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())))
            
            return onboardingViewController.view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            
        }
    }
}
