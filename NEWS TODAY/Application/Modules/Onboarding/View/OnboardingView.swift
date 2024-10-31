//
//  OnboardingView.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 30.10.2024.
//

import UIKit
import SwiftUI

//MARK: - Protocols
protocol OnboardingView: UIView {
    var scrollView: UIScrollView { get }
    var pageControl: UIPageControl { get }
}

class OnboardingViewImpl: UIView, OnboardingView {
    
    //MARK: - UI
    internal let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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
    
    internal let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.onb1
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 16
        return image
    }()
    
    internal let firstToKnowLabel = UILabel(
        text: "First to know",
        font: .InterSemiBold(ofSize: 24),
        textColor: .blackPrimary
    )
    
    internal let descriptionLabel = UILabel(
        text: "Get the latest news and updates from our team",
        font: .InterRegular(ofSize: 16),
        textColor: .greyPrimary,
        numberOfLines: 2
    )
    
    internal let nextButton = UIButton(initPurpleButton: .purplePrimary, text: "Next"
        )
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupView(){
        [scrollView,
         pageControl,
         imageView,
         firstToKnowLabel,
         descriptionLabel,
         nextButton
        ].forEach(addSubview)
    }
    
    func configureView(
        firstText: String?,
        descriptionText: String,
        nextText: String,
        image: String
    ) {
        firstToKnowLabel.text = firstText
        descriptionLabel.text = descriptionText
        nextButton.titleLabel?.text = nextText
        imageView.image = UIImage(named: image)
    }
    
    func setUpSlidesScrollView(slides: [OnboardingView]) {
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(slides.count), height: frame.height)
    }

    //MARK: - setupConstraints
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 336),
            
            pageControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            firstToKnowLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30),
            firstToKnowLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: firstToKnowLabel.bottomAnchor, constant: 30),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            
            nextButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct OnbView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingViewWrapper1()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct OnboardingViewWrapper1: UIViewRepresentable {
  
    func makeUIView(context: Context) -> UIView {
        let onboardingViewController = OnboardingViewImpl()
        return onboardingViewController
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
