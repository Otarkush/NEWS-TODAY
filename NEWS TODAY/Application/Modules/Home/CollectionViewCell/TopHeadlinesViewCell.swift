//
//  TopHeadlinesViewCell.swift
//  NEWS TODAY
//
//  Created by Daria Arisova on 03.11.2024.
//

import UIKit

class TopHeadlinesViewCell: UICollectionViewCell {
    static let identifier = "TopHeadlinesViewCell"
    
    public lazy var headlineView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 16
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.InterRegular(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.InterBold(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public lazy var favoriteButton = ActionButton(.favorite)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        searchBarConstraints()
    }
    
    func configure(topHeadlines: News) {
        imageView.image = topHeadlines.img
        categoryLabel.text = topHeadlines.category
        titleLabel.text = topHeadlines.title
//        let searchImage = topHeadlines.favorite ? "" : ""
//        let searchImageAlwaysOriginal = searchImage.withRenderingMode(.alwaysOriginal)
//        imageView.setImage(searchImageAlwaysOriginal, for: .normal)
//        favoriteButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    }
      
    private func searchBarConstraints() {
        addSubview(headlineView)
//        addSubview(imageView)
        [imageView,
         categoryLabel,
         titleLabel,
         favoriteButton
        ].forEach(headlineView.addSubview)
        
        NSLayoutConstraint.activate([
            headlineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headlineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            headlineView.widthAnchor.constraint(equalToConstant: 256),
            headlineView.heightAnchor.constraint(equalToConstant: 256),
//            
            imageView.topAnchor.constraint(equalTo: headlineView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: headlineView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: headlineView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: headlineView.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: headlineView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: headlineView.centerYAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 256),
//            imageView.heightAnchor.constraint(equalToConstant: 256),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -24),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24),
//            
            categoryLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            categoryLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -24),
////            
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 24),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -24),
        ])
    }
}
