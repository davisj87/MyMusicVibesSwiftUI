//
//  AlbumTracksEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct AlbumTracksEndpoint: AuthorizedEndpoint {
    var id:String
    
    var host: String {
        return "https://api.spotify.com"
    }
    
    var path: String {
        return "/v1/albums/\(self.id)/tracks"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [String : String]? {
        return nil
    }
    
    typealias ModelType = ObjectItemWrapper<AlbumTracksObject>
}
