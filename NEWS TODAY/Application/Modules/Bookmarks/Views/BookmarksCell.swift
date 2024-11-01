//
//  BookmarksCell.swift
//  NEWS TODAY
//
//  Created by Andrew Linkov on 28.10.2024.
//

import UIKit

class BookmarkCell: UITableViewCell {
    
    //MARK: - UI Components
    private let bookmarkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "Capital")
        image.layer.cornerRadius = 12
        return image
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel ()
        label.font = .systemFont(ofSize: 14)
        label.tintColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel ()
        label.font = .systemFont(ofSize: 16)
        label.tintColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func set(info: Article) {
        DispatchQueue.main.async {
            self.bookmarkImage.loadImage(withURL: <#T##String#>, id: <#T##String#>)
        }
        
        categoryLabel.text = info.author
        mainLabel.text = info.title
    }
    
    private func configure() {
        [bookmarkImage, categoryLabel, mainLabel].forEach {addSubview($0) }
    }
}

extension BookmarkCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bookmarkImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 72),
            bookmarkImage.widthAnchor.constraint(equalToConstant: 96),
            bookmarkImage.heightAnchor.constraint(equalToConstant: 96),
            
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: bookmarkImage.leadingAnchor, constant: 8),

            mainLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            mainLabel.leadingAnchor.constraint(equalTo: bookmarkImage.trailingAnchor, constant: 8),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
    }
}

