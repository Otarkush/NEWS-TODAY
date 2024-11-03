//
//  ListSection.swift
//  NEWS TODAY
//
//  Created by Daria Arisova on 31.10.2024.
//

import Foundation

struct ListItem {
    let title: String
    let categoryTitle: String
    let img: String
}

enum ListSection {
    case browse([ListItem])
    case discover([ListItem])
//    case searchBar([ListItem])
//    case categories([ListItem])
//    case newsForCategoty([ListItem])
//    case recommendedNews([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .browse(var items),
                .discover(var items)/*,
                .searchBar(var items),
                .categories(var items),
                .newsForCategoty(var items),
                .recommendedNews(var items)*/:
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
}
