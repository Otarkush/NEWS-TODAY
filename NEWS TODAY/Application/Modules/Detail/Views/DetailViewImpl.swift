//
//  DetailViewImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 26.10.2024.
//

import UIKit
import SwiftUI
#warning("кол-во элементов протокола не избыточно?")
protocol DetailView: UIView {
    var scrollView: UIScrollView { get }
    var imageView: UIImageView { get }
    var contentView: UIView { get }
    var backButton: ActionButton { get }
    var shareButton: ActionButton { get }
    var favoriteButton: ActionButton { get }
    var authorNameLabel: UILabel { get }
    var newsHeaderLabel: UILabel { get }
    var authorGreyLabel: UILabel { get }
    var categoryLabel: UILabel { get }
    var detailsTextView: UITextView { get }
}

class DetailViewImpl: UIView, DetailView {
    
    // MARK: - UI
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purplePrimary
        label.textColor = .white
        label.font = .InterSemiBold(ofSize: 12)
        label.textAlignment = .center
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailsTextView: UITextView = {
        let textView = UITextView()
        textView.font = .InterRegular(ofSize: 16)
        textView.textColor = .greyDarker
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let backButton = ActionButton(.back)
    let shareButton = ActionButton(.share)
    let favoriteButton = ActionButton(.favorite)
    
    let newsHeaderLabel = UILabel(
        font: UIFont.InterBold(ofSize: 20),
        numberOfLines: 2
    )
    let authorNameLabel = UILabel(
        font: UIFont.InterSemiBold(ofSize: 16)
    )
    let authorGreyLabel = UILabel(
        text: Drawings.authorRoleText,
        font: UIFont.InterRegular(ofSize: 14),
        textColor: .lightGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupView() {
        backgroundColor = .white
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
         authorGreyLabel,
         detailsTextView
        ].forEach(contentView.addSubview)
    }
}

// MARK: - DetailViewController + Constraints
extension DetailViewImpl {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Drawings.imageHeight),
            
            backButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: Drawings.buttonTopOffset),
            backButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Drawings.buttonLeadingOffset),
            
            favoriteButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Drawings.buttonTrailingOffset),
            
            shareButton.centerXAnchor.constraint(equalTo: favoriteButton.centerXAnchor),
            shareButton.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: Drawings.shareButtonTopOffset),
            
            categoryLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: Drawings.categoryLabelTopOffset),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Drawings.categoryLabelLeadingOffset),
            categoryLabel.widthAnchor.constraint(equalToConstant: Drawings.categoryLabelWidth),
            
            newsHeaderLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            newsHeaderLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: Drawings.newsHeaderLabelTopOffset),
            newsHeaderLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: Drawings.newsHeaderLabelTrailingOffset),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: newsHeaderLabel.leadingAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: newsHeaderLabel.bottomAnchor, constant: Drawings.authorNameLabelTopOffset),
            
            authorGreyLabel.leadingAnchor.constraint(equalTo: authorNameLabel.leadingAnchor),
            authorGreyLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: Drawings.authorGreyLabelTopOffset),
            
            detailsTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Drawings.detailsTextViewTopOffset),
            detailsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Drawings.detailsTextViewLeadingOffset),
            detailsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Drawings.detailsTextViewTrailingOffset),
            detailsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}

// MARK: - Drawings Enum
enum Drawings {
    static let categoryText = "Politics"
    static let newsHeaderText = "The latest situation in the presidential election"
    static let authorNameText = "John Doe"
    static let authorRoleText = "Author"
    static let detailsText = """
    Results
    
    The presidential election continues to be a closely contested race, with leads in individual states frequently changing hands as more votes are counted. In each state, counting practices vary, and as a result, the time it takes to declare a winner also differs. This has led to a prolonged election process, with some states yet to declare a final outcome. Early projections suggested a strong lead for certain candidates, but as mail-in and absentee ballots are counted, the dynamics have shifted dramatically.

    According to analysts, the most critical swing states, including Pennsylvania, Michigan, and Arizona, have seen razor-thin margins that could ultimately determine the winner of this election. The delay in finalizing results has sparked a lot of discussions and debates across the country, with supporters from both sides eagerly awaiting the outcome. Political experts suggest that this year’s election may redefine how the nation views its electoral process, especially with a record number of early and mail-in ballots due to the ongoing pandemic.

    For a more detailed breakdown, individual state pages offer county-by-county analyses, showcasing how different regions within each state voted. For instance, urban centers tend to lean towards one candidate, while rural areas show support for the other. These geographical trends underline the diverse political landscape of the United States and highlight the unique challenges in counting votes that represent such a wide array of communities.

    Additionally, ongoing recounts and legal challenges have added another layer of complexity to the election. In several states, lawsuits have been filed over the legitimacy of certain ballots, and recounts are underway in areas with very close margins. The possibility of a prolonged battle in the courts has many voters feeling uncertain about when they will know the final outcome.

    Political analysts also note the historical significance of this election, as voter turnout has reached unprecedented levels. Millions of Americans, both young and old, turned out to cast their votes, indicating a renewed interest in the democratic process. Observers say that this level of engagement among citizens may influence future elections and inspire changes in how the voting process is conducted.

    With each new batch of counted ballots, the nation watches closely. Every update, every count, brings the country one step closer to knowing who will take office. Until all the votes are in and certified, speculation and analysis will continue, fueling conversations and debates across the nation.

    Results in individual states may continue to shift as all votes are meticulously counted. Select a state for detailed results, and use the tabs for Senate, House, or Governor races to view specific outcomes. For more comprehensive updates and official statements, refer to the National Election Pool or Reuters for the latest verified information.

    Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House, or Governor tabs to view those races. This election has underscored the importance of every single vote and has reaffirmed the democratic values of the country in uncertain times.

    For more detailed state results, click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters.
    """
    
    static let imageHeight: CGFloat = 350
    static let buttonTopOffset: CGFloat = 52
    static let buttonLeadingOffset: CGFloat = 20
    static let buttonTrailingOffset: CGFloat = -20
    static let shareButtonTopOffset: CGFloat = 24
    static let categoryLabelTopOffset: CGFloat = 100
    static let categoryLabelLeadingOffset: CGFloat = 20
    static let categoryLabelWidth: CGFloat = 75
    static let newsHeaderLabelTopOffset: CGFloat = 16
    static let newsHeaderLabelTrailingOffset: CGFloat = -20
    static let authorNameLabelTopOffset: CGFloat = 25
    static let authorGreyLabelTopOffset: CGFloat = 2
    static let detailsTextViewTopOffset: CGFloat = 15
    static let detailsTextViewLeadingOffset: CGFloat = 20
    static let detailsTextViewTrailingOffset: CGFloat = -20
    static let textFontSize: CGFloat = 16
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
