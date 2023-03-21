//
//  AuthEndpoint.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation
import CryptoKit


enum PKCEError: Error {
    case failedToGenerateRandomOctets
    case failedToCreateChallengeForVerifier
}

struct AuthEndpoint {
    var host: String {
        return "https://accounts.spotify.com"
    }
    
    var path: String {
        return "/authorize"
    }
    
//    var codeChallenge: String? {    // This is what we will use to pass the code challenge to Request Token
//        return challenge
//    }
    
    var codeVerifier:String? {
        return verifier
    }
    
    private var challenge: String?
    private var verifier:String?
    
    var queryItems: [String : String]? {
        var qDict:[String:String] = [:]
        
        qDict["client_id"] = Credentials.clientID
        qDict["response_type"] = "code"
        qDict["redirect_uri"] = Credentials.redirectURI
        qDict["scope"] = Credentials.scope
        qDict["code_challenge_method"] = "S256"
        if let cHashString = self.challenge {
            qDict["code_challenge"] = cHashString
        }
        return qDict
    }
    
   init() {
        do {
            try self.getHashString()
        } catch {
            print("issue with code challenge")
        }
    }
}

extension AuthEndpoint {
    var url: URL {
        var components = URLComponents(string: host)!
        components.path = path
        components.queryItems = [
        URLQueryItem(name: "format", value: "json")
        ]
        if let cQueryItems = self.queryItems {
            let additionalQueryItems = cQueryItems.compactMap{ item in
                URLQueryItem(name: item.key, value: item.value)
            }
            components.queryItems?.append(contentsOf:additionalQueryItems)
        }
        return components.url!
    }
}

extension AuthEndpoint {
    private mutating func getHashString() throws {
        let octets = try self.generateCryptographicallySecureRandomOctets(count: 32)
        let codeVerifier = self.base64URLEncode(octets: octets)
        self.verifier = codeVerifier
        self.challenge = try self.challenge(for: codeVerifier)
    }
    
    private func generateCryptographicallySecureRandomOctets(count: Int) throws -> [UInt8] {
        var octets = [UInt8](repeating: 0, count: count)
        let status = SecRandomCopyBytes(kSecRandomDefault, octets.count, &octets)
        if status == errSecSuccess { // Always test the status.
            return octets
        } else {
            throw PKCEError.failedToGenerateRandomOctets
        }
    }
    
    private func base64URLEncode<S>(octets: S) -> String where S: Sequence, UInt8 == S.Element {
        let data = Data(octets)
        return data
            .base64EncodedString() // Regular base64 encoder
            .replacingOccurrences(of: "=", with: "") // Remove any trailing '='s
            .replacingOccurrences(of: "+", with: "-") // 62nd char of encoding
            .replacingOccurrences(of: "/", with: "_") // 63rd char of encoding
            .trimmingCharacters(in: .whitespaces)
    }
    
    private func challenge(for verifier: String) throws -> String {
         let challenge = verifier // String
             .data(using: .ascii) // Decode back to [UInt8] -> Data?
             .map { SHA256.hash(data: $0) } // Hash -> SHA256.Digest?
             .map { base64URLEncode(octets: $0) } // base64URLEncode
         if let challenge = challenge {
             return challenge
         } else {
             throw PKCEError.failedToCreateChallengeForVerifier
         }
     }
}
