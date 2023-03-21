//
//  SingleTrackDetailEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct SingleTrackDetailEndpoint: AuthorizedEndpoint {
    var id:String
    
    var host: String {
        return "https://api.spotify.com"
    }
    
    var path: String {
        return "/v1/audio-features/\(self.id)"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [String : String]? {
        return nil
    }
    
    typealias ModelType = TrackFeaturesObject
}
