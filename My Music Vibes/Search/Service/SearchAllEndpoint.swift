//
//  SearchAllEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation
struct SearchAllEndpoint: SearchEndpoint {
    var limit: Int = 20
    
    var offset: Int = 0
    
    var searchString: String
    
    var searchType: SearchType? {
        return .all
    }
    
    typealias ModelType = SearchAllWrapper
}
