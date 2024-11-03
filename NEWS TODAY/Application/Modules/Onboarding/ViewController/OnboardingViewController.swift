//
//  OnboardingViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

protocol OnboardingViewPresenter: AnyObject {
    func didTapNext()
    func didTapStart()
}

final class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    private let presenter: OnboardingViewPresenter?
    private var slides = [OnboardingView]()
    
    // MARK: - UI
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
         scrollView.isDirectionalLockEnabled = true
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
        view.backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        scrollView.delegate = self
        setupView()
        slides = createSlides()
        setUpSlidesScrollView(slides: slides)
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.layoutIfNeeded()
        scrollView.setContentOffset(.zero, animated: false)
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
            description: "All news in one place, be the first to know last news",
            nextButtonTitle: "Next",
            target: self,
            action: #selector(handleNextButtonTap)
        )
       
        
        let slide2 = OnboardingViewImpl()
        slide2.setupSlideUI(
            image: "onb2",
            title: "Customize Your Feed",
            description: "Choose topics , so you only see the news that matters.",
            nextButtonTitle: "Next",
            target: self,
            action: #selector(handleNextButtonTap)
        )
        
        let slide3 = OnboardingViewImpl()
        slide3.setupSlideUI(
            image: "onb3",
            title: "Ready to Begin?" ,
            description: "Explore the latest stories, customize your experience!" ,
            nextButtonTitle: "Get Started",
            target: self,
            action: #selector(handleGetReadyButtonTap)
        )
        
        return [slide1, slide2, slide3]
    }
    
    func setUpSlidesScrollView(slides: [OnboardingView]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)

        for (index, slide) in slides.enumerated() {
            slide.frame = CGRect(
                x: view.frame.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
            scrollView.addSubview(slide)
        }
    }
    
    @objc private func handleNextButtonTap() {
        presenter?.didTapNext()
    }
    
    @objc private func handleGetReadyButtonTap() {
        presenter?.didTapStart()
    }
    
}



extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maxHorizontalOffset = scrollView.contentSize.width - view.frame.width
        let percentHorizontalOffset = scrollView.contentOffset.x / maxHorizontalOffset
        
        if percentHorizontalOffset <= 0.5 {
            let firstTransform = CGAffineTransform(scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                                                   y: (0.5 - percentHorizontalOffset) / 0.5)
            let secondTransform = CGAffineTransform(scaleX: percentHorizontalOffset / 0.5,
                                                    y: percentHorizontalOffset / 0.5)
            
            slides[0].setPageLabelTransform(transform: firstTransform)
            slides[1].setPageLabelTransform(transform: secondTransform)
        } else {
            let secondTransform = CGAffineTransform(scaleX: (1 - percentHorizontalOffset) / 0.5,
                                                    y: (1 - percentHorizontalOffset) / 0.5)
            let thirdTransform = CGAffineTransform(scaleX: percentHorizontalOffset,
                                                   y: percentHorizontalOffset)
            
            slides[1].setPageLabelTransform(transform: secondTransform)
            slides[2].setPageLabelTransform(transform: thirdTransform)
        }
    }
}

//MARK: - OnboardingViewController + OnboardingViewDelegate
extension OnboardingViewController: OnboardingViewDelegate {
    func updateUI() {
        
    }
    
    
    func scrollToNextSlide() {
          let nextPage = min(pageControl.currentPage + 1, slides.count - 1)
          let offsetX = CGFloat(nextPage) * view.frame.width
          scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
          pageControl.currentPage = nextPage
      }
}

extension OnboardingViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageControl.topAnchor.constraint(equalTo: slides[0].imageView.bottomAnchor, constant: 40),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
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
        let onboardingViewController = OnboardingViewController(presenter: OnboardingViewPresenterImpl(networking: NetworkingManagerImpl(), router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())))
        
        return onboardingViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
