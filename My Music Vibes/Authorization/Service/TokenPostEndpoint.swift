//
//  TokenPostEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol TokenPostEndpoint: Endpoint {               //Use this Endpoint for Token and RefreshToken
    var payload: [String:String]? { get }
    var payloadEncoding:PayloadEncodingMethod? { get }
}
extension TokenPostEndpoint {
    
    var method: RequestMethod {
        return .post
    }
    
    var requiresAuth: Bool {
        return false
    }
    
    var payloadData:Data? {
        guard let cPayloadEncoding = payloadEncoding else {
            return nil
        }
        switch cPayloadEncoding {
        case .formUrl:
            var requestBodyComp = URLComponents()
            if let cPayload = self.payload {
                requestBodyComp.queryItems = cPayload.compactMap{ item in
                    URLQueryItem(name: item.key, value: item.value)
                }
            }
            return requestBodyComp.query?.data(using: .utf8)
        case .json:
            if let cPayload = self.payload {
                return cPayload.JSONData
            }
        }
        return nil
    }
}
