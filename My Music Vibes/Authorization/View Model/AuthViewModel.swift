//
//  AuthViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

enum WebViewState {
    case loading
    case success
    case failure
    case none
}

class AuthViewModel:ObservableObject {
    @Published var webViewState: WebViewState = .none
    private let authEndpoint = AuthEndpoint()
    var authEndpointURL:URL {
        return authEndpoint.url
    }
    func getAndSaveAuthToken(authCode:String) async throws {
        guard let codeVerifier = self.authEndpoint.codeVerifier else {
            throw RequestError.unauthorized
        }
        var tokenEndpoint = TokenEndpoint()
        tokenEndpoint.authCode = authCode
        tokenEndpoint.codeVerifier = codeVerifier
        
        let tokenRequest = AuthRequest(endpoint: tokenEndpoint)
        
        guard let tokenObject = try await tokenRequest.executeRequestWithPayload(tokenEndpoint.payloadData) else {
            throw RequestError.missingToken
        }
        let calendar = Calendar.current
        guard let expirationDate = calendar.date(byAdding: .second, value: tokenObject.expiresIn - 120 , to: Date()) else {
            throw RequestError.missingToken
        }
        
        let auth = TokenStorageObject(authToken: tokenObject.authToken, refreshToken: tokenObject.refreshToken, expiresIn: expirationDate)
        let service = KeychainHelper.tokenSeviceStr
        
        // Save `auth` to keychain
        KeychainHelper.standard.save(auth, service: service)
        
    }
}
