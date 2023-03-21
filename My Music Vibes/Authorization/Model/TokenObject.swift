//
//  TokenObject.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct TokenObject:Decodable {
    let authToken: String
    let refreshToken:String
    let expiresIn:Int
    let scope: String
    
    private enum CodingKeys: String, CodingKey {
        case scope
        case authToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
}

extension TokenObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.authToken = try container.decodeIfPresent(String.self, forKey: .authToken) ?? "N/A"
        self.refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken) ?? "N/A"
        self.scope = try container.decodeIfPresent(String.self, forKey: .scope) ?? "N/A"
        self.expiresIn = try container.decodeIfPresent(Int.self, forKey: .expiresIn) ?? 0

    }
}
