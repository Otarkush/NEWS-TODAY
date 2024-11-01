//
//  BookmarksModel.swift
//  NEWS TODAY
//
//  Created by Andrew Linkov on 28.10.2024.
//

import UIKit
import Foundation

struct Bookmarks {
    let bookmarkImage = UIImage(named: "Capital")
    let categoryLabel = "Capital"
    let textLabel = "Capital"
}

struct SearchResults {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article {
    var source = "BBC News"
    var author = "Bill"
    var title = "Warn"
    var description = "ds"
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

}

struct Source {
    var id: String?
    let name: String?
}
