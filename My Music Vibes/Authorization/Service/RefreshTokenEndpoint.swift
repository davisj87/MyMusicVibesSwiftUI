//
//  RefreshTokenEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct RefreshTokenEndpoint: TokenPostEndpoint {

    var payload: [String : String]? {
        var pDict:[String:String] = [:]
        let service = KeychainHelper.tokenSeviceStr
        if let tokenObject = KeychainHelper.standard.read(service: service,
                                        type: TokenStorageObject.self) {
            
            pDict["refresh_token"] = tokenObject.refreshToken
        }
            
        pDict["grant_type"] = "refresh_token"
        //pDict["refresh_token"] = Credentials.refreshToken
        pDict["client_id"] = Credentials.clientID
        return pDict
    }
    
    var payloadEncoding: PayloadEncodingMethod? {
        return .formUrl
    }
    
    var host: String {
        return "https://accounts.spotify.com"
    }
    
    var path: String {
        return "/api/token"
    }
    
    var queryItems: [String : String]?
    typealias ModelType = TokenObject
    
}
