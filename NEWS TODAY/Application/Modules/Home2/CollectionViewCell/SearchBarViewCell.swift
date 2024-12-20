//////
//////  SearchBarViewCell.swift
//////  NEWS TODAY
//////
//////  Created by Daria Arisova on 31.10.2024.
//////
////
//import UIKit
//
//class SearchBarViewCell: UICollectionViewCell {
//    static let identifier = "SearchBarViewCell"
//    
//    public lazy var searchBlockStackView: UIStackView = {
//        let element = UIStackView()
//        element.axis = .horizontal
//        element.backgroundColor = UIColor.grayLighter
//        element.layer.cornerRadius = 12.0
//        element.spacing = 24
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
//    
//    public lazy var searchButton: UIButton = {
//        let element = UIButton(type: .system)
//        element.tintColor = UIColor.grayPrimary
//        let searchImage = #imageLiteral(resourceName: "search")
//        let searchImageAlwaysOriginal = searchImage.withRenderingMode(.alwaysOriginal)
//        element.setImage(searchImageAlwaysOriginal, for: .normal)
////        element.setImage(#imageLiteral(resourceName: "search"), for: .normal)
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
//    
//    public lazy var searchTextField: UITextField = {
//        let element = UITextField()
//        element.placeholder = "Search"
//        element.textColor = UIColor.grayPrimary
//        element.font = UIFont.InterBold(ofSize: 16)
//        element.translatesAutoresizingMaskIntoConstraints = false
//        element.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        return element
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//     
//     @objc private func textFieldDidChange(_ textField: UITextField) {
//         guard let text = textField.text else { return }
//         delegate?.didUpdateSearchQuery(text)
//     }
//    
//    private func commonInit() {
//        searchBarConstraints()
//    }
//    
//    func configure(searchBar: NewSearchBar) {
//        
//    }
//      
//    private func searchBarConstraints() {
//        addSubview(searchBlockStackView)
//        searchBlockStackView.addArrangedSubview(searchButton)
//        searchBlockStackView.addArrangedSubview(searchTextField)
//        
//        NSLayoutConstraint.activate([
//            searchBlockStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            searchBlockStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            searchBlockStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            searchBlockStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            searchBlockStackView.heightAnchor.constraint(equalToConstant: 56),
//            
//            searchButton.leadingAnchor.constraint(equalTo: searchBlockStackView.leadingAnchor, constant: 16),
//            searchButton.widthAnchor.constraint(equalToConstant: 24),
//            
//            searchTextField.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 24),
//            searchTextField.trailingAnchor.constraint(equalTo: searchBlockStackView.trailingAnchor, constant: -16),
//        ])
//    }
//}
