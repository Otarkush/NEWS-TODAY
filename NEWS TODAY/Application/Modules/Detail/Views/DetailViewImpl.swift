//
//  DetailViewImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 26.10.2024.
//

import UIKit
import SwiftUI

protocol DetailView: UIView {
    var scrollView: UIScrollView { get }
    var imageView: UIImageView { get }
    var contentView: UIView { get }
    var backButton: ActionButton { get }
}

class DetailViewImpl: UIView, DetailView {
    
    //MARK: - UI
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.capital
        return imageView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .green
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Politics"
        label.backgroundColor = UIColor.purplePrimary
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backButton = ActionButton(.back)
    let shareButton = ActionButton(.share)
    let favoriteButton = ActionButton(.favorite)
    
    let newsHeaderLabel = UILabel(text: "The latest situation in the presidential election", numberOfLines: 2)
    let authorNameLabel = UILabel(text: "Bob Shmob")
    let authorGreyLabel = UILabel(text: "Author", textColor: .greyLighter)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [imageView,
         backButton,
         shareButton,
         favoriteButton,
         authorNameLabel,
         newsHeaderLabel,
         authorGreyLabel,
         categoryLabel,
         authorNameLabel,
         authorGreyLabel
        ].forEach(contentView.addSubview)
        
    }
}

//MARK: - DetailViewController + Constraints
extension DetailViewImpl {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 370),
            
            backButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 52),
            backButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            
            favoriteButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            shareButton.centerXAnchor.constraint(equalTo: favoriteButton.centerXAnchor),
            shareButton.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 24),
            
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            
            newsHeaderLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            newsHeaderLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            newsHeaderLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20)
            
        ])
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct DetailViewImpl_Preview: PreviewProvider {
    static var previews: some View {
        DetailViewImplWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct DetailViewImplWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = DetailViewImpl()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
