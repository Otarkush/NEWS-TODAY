//
//  MockData.swift
//  NEWS TODAY
//
//  Created by Daria Arisova on 31.10.2024.
//

import Foundation

struct MockData {
    static var shared = MockData()
    
    public var browse: ListSection = {
        .browse([])
    }()
    
    public var discover: ListSection = {
        .discover([])
    }()
    
//    public var searchBar: ListSection = {
//        .searchBar([])
//    }()
//    
//    public var categories: ListSection = {
//        .categories([])
//    }()
    
    var pageData: [ListSection] {
        [browse, discover/*, searchBar, categories*/]
    }
}
