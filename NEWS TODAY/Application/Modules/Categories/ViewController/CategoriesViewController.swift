//
//  CategoriesViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//


import UIKit
import SwiftUI
import Repository

//TODO: Рефактор под нашу архитектуру

protocol CategoriesViewPresenter: AnyObject {
    func fetchCategories() -> [Category]
    func viewDidLoad()
}

final class CategoriesViewController: UIViewController {
  
    //MARK: - Properties
    private let presenter: CategoriesViewPresenter
    var categories = [Category]()
    var selectedCategories = [Category]()
    
    //MARK: - Init
    init(presenter: CategoriesViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private let titleLabel = UILabel(
        text: "Categories",
        font: UIFont.InterSemiBold(ofSize: 24),
        textColor: UIColor.blackPrimary,
        numberOfLines: 1)
    
    private let subtitleLabel = UILabel(
        text:
            "Thousands of articles in each category",
        font: UIFont.InterRegular(ofSize: 16),
        textColor: UIColor.greyPrimary,
        numberOfLines: 1)
    
    private let horizontalStackView = UIStackView(axis: .horizontal)
    private let leftStackView = UIStackView(axis: .vertical)
    private let rightStackView = UIStackView(axis: .vertical)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        presenter.viewDidLoad()
        setupCategories()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        [titleLabel, subtitleLabel, horizontalStackView].forEach(view.addSubview) 
        [leftStackView,rightStackView].forEach(horizontalStackView.addArrangedSubview)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
             
             titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),

             
             subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
             subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),

             
             horizontalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
             horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
         ])
        }
    
    private func setupCategories() {
        
          let halfIndex = categories.count / 2
          let leftCategories = Array(categories[..<halfIndex])
          let rightCategories = Array(categories[halfIndex...])
          
          setupStackView(leftStackView, with: leftCategories)
          setupStackView(rightStackView, with: rightCategories)
      }
    
    private func setupStackView(_ stackView: UIStackView, with categories: [Category]) {
        categories.forEach { category in
            
            let button = UIButton(initBackgroundColor: .greyLighter)
            
            button.setTitle("\(category.emoji) \(category.name)",
                            for: .normal)

            button.addTarget(self,
                             action: #selector(categoryTapped(_:)),
                             for: .touchUpInside)
            if selectedCategories.contains(where: { $0.name == category.name }) {
                button.backgroundColor = .purplePrimary
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .greyLighter
                button.setTitleColor(.greyDarker, for: .normal)
            }
            
            if selectedCategories.contains(where: { $0.name == category.name }) {
                button.backgroundColor = .purplePrimary
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .greyLighter
                button.setTitleColor(.greyDarker, for: .normal)
            }
            
            stackView.addArrangedSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false

            let heightConstraint = button.heightAnchor.constraint(lessThanOrEqualToConstant: 72)
            heightConstraint.priority = .defaultHigh

            NSLayoutConstraint.activate([
                heightConstraint
            ])
        }
    }
    
    // MARK: - Objcs methods
    @objc private func categoryTapped(_ sender: UIButton) {
        
        let allButtons = leftStackView.arrangedSubviews + rightStackView.arrangedSubviews
        
        guard let index = allButtons.firstIndex(of: sender), index < categories.count else { return }

        let category = categories[index]
        
        if let selectedIndex = self.selectedCategories.firstIndex(where: { $0.id == category.id }) {
            
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = .greyLighter
                sender.setTitleColor(.greyDarker, for: .normal)
            }
            self.selectedCategories.remove(at: selectedIndex)
        } else {
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = .purplePrimary
                sender.setTitleColor(.white, for: .normal)
            }
            self.selectedCategories.append(category)
        }
        _ = self.selectedCategories.map { $0.name }
    }
    }

//MARK: - CategoriesViewController + CategoriesViewDelegate
extension CategoriesViewController: CategoriesViewDelegate {
    func updateUI(with categories: [Category]) {
        self.categories = categories
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct CategoriesViewController_Preview: PreviewProvider {
    static var previews: some View {
        CategoriesViewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct CategoriesViewWrapper: UIViewRepresentable {
  
    func makeUIView(context: Context) -> UIView {
        let categoriesViewController = CategoriesViewController(presenter: CategoriesViewPresenterImpl(networking: NewsRepository.shared, router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())))
        
        
        return categoriesViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
