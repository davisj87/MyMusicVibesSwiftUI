//
//  TokenEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct TokenEndpoint: TokenPostEndpoint {
    var payload: [String : String]? {
        var pDict:[String:String] = [:]
        
        pDict["grant_type"] = "authorization_code"
        pDict["client_id"] = Credentials.clientID
        pDict["redirect_uri"] = Credentials.redirectURI
        if let codeVerifier = self.codeVerifier, let authCode = self.authCode {
            pDict["code"] = authCode
            pDict["code_verifier"] = codeVerifier
        }
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
    
    var authCode:String?        //This is the value you receive from the response from the RequestAuthEndpoint
    var codeVerifier:String?    //This is the same value that was used for codeChallenge property of the RequestAuthEndpoint
    
    var queryItems: [String : String]?
    typealias ModelType = TokenObject
    
    
}
