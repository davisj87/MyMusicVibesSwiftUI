//
//  SearchArtistEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct SearchArtistEndpoint: SearchEndpoint {

    var searchString: String
    
    var limit: Int
    
    var offset: Int
    
    var searchType: SearchType? {
        return .artist
    }

    typealias ModelType = ArtistWrapper
    
}
