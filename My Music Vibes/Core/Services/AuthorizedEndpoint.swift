//
//  AuthorizedEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol AuthorizedEndpoint: Endpoint {}

extension AuthorizedEndpoint {
    var requiresAuth: Bool {
        return true
    }
}
