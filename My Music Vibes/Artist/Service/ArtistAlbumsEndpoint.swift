//
//  ArtistAlbumsEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct ArtistAlbumsEndpoint: AuthorizedEndpoint {
    var id:String
    var limit:Int
    var offset:Int
    
    var host: String {
        return "https://api.spotify.com"
    }
    
    var path: String {
        return "/v1/artists/\(self.id)/albums"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [String : String]? {
        var qDict:[String:String] = [:]
        qDict["market"] = "US"
        qDict["limit"] = String(self.limit)
        qDict["offset"] = String(self.offset)
        return qDict
    }
    
    typealias ModelType = ObjectItemWrapper<AlbumObject>
}
