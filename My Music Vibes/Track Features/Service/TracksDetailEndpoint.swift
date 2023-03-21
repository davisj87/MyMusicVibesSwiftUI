//
//  TracksDetailEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct TracksDetailEndpoint: AuthorizedEndpoint {
    var ids:String
    
    var host: String {
        return "https://api.spotify.com"
    }
    
    var path: String {
        return "/v1/audio-features"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [String : String]? {
        var qDict:[String:String] = [:]
        qDict["ids"] = self.ids
        return qDict
    }
    
    typealias ModelType = TrackAudioFeatures
}
