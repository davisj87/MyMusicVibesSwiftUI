//
//  TopTracksEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct TopTracksEndpoint: AuthorizedEndpoint {
    
    var host: String {
        return "https://api.spotify.com"
    }
    
    var path: String {
        return "/v1/me/top/tracks"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [String : String]? {
        var qDict:[String:String] = [:]
        qDict["limit"] = "10"
        return qDict
    }
    
    typealias ModelType = ObjectItemWrapper<TracksObject>
}
