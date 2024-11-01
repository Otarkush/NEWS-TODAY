//
//  BookmarksCell.swift
//  NEWS TODAY
//
//  Created by Andrew Linkov on 28.10.2024.
//
//
//import UIKit
//
//class BookmarkCell: UITableViewCell {
//    
//    //MARK: - UI Components
//    private let bookmarkImage: UIImageView = {
//            let image = UIImageView()
//            image.image = UIImage(systemName: "Capital")
//            image.layer.cornerRadius = 12
//            image.clipsToBounds = true
//            image.translatesAutoresizingMaskIntoConstraints = false
//            return image
//        }()
//        
//        private let categoryLabel: UILabel = {
//            let label = UILabel()
//            label.font = .systemFont(ofSize: 14)
//            label.textColor = .lightGray
//            label.numberOfLines = 1
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//        
//        private let mainLabel: UILabel = {
//            let label = UILabel()
//            label.font = .systemFont(ofSize: 16)
//            label.textColor = .black
//            label.numberOfLines = 0
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//    }
//    
//    //MARK: - Initializer
//    
////init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
////        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configure()
//        setupConstraints()
//    }
//    
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//    
//    //MARK: - Public Methods
//    
//    func set(info: Article) {
//        var bookmarkImage = UIImage(named: "Capital")
//        }
//        
//        categoryLabel.text = info.author
//        mainLabel.text = info.title
//    }
//    
//    private func configure() {
//        [bookmarkImage, categoryLabel, mainLabel].forEach {addSubview($0) }
//    }
//}
//
//extension BookmarkCell {
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            bookmarkImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            bookmarkImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            bookmarkImage.widthAnchor.constraint(equalToConstant: 96),
//            bookmarkImage.heightAnchor.constraint(equalToConstant: 96),
//            
//            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            categoryLabel.leadingAnchor.constraint(equalTo: bookmarkImage.trailingAnchor, constant: 8),
//            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            
//            mainLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
//            mainLabel.leadingAnchor.constraint(equalTo: bookmarkImage.trailingAnchor, constant: 8),
//            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            mainLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
//        ])
//    }
//}
//
