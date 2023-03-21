//
//  NetworkRequest.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation


protocol NetworkRequest {
    associatedtype ModelType: Decodable
    func decode(_ data: Data) -> ModelType?
    func setRequestMethodAndHeaders<T: Endpoint>(endpoint: T) async throws -> URLRequest
    func executeRequest() async throws -> ModelType?
    func executeRequestWithPayload(_ payload:Data?) async throws -> ModelType?
}

extension NetworkRequest {
    
    fileprivate func request(_ request: URLRequest, payload:Data?) async throws -> ModelType? {
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            print(response.statusCode)
//            print(data.JSONObject)
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = self.decode(data) else {
                throw RequestError.decode
            }
                return decodedResponse
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unexpectedStatusCode
            }
            
        } catch {
            throw RequestError.unknown
        }
    }
}

struct APIRequest<Resource: Endpoint> {
    let endpoint: Resource
    let authManager: AuthManager
    
    init(endpoint:Resource, authManager: AuthManager) {
        self.endpoint = endpoint
        self.authManager = authManager
    }
}

extension APIRequest: NetworkRequest {
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let wrapper = try? decoder.decode(Resource.ModelType.self, from: data)
        return wrapper
    }
    
    func setRequestMethodAndHeaders<T>(endpoint: T) async throws -> URLRequest where T : Endpoint {
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // check here for a valid token
        // If token is invalid then authmanager try to refesh before making the network call
        // If refresh is successful then continue with the normal call
        // If refresh isn't successful throw an error
        
        guard let token = try await authManager.validToken() else {
            throw RequestError.unauthorized
        }
        urlRequest.setValue("Bearer \(token.authToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(PayloadEncodingMethod.json.rawValue, forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
   func executeRequest() async throws -> Resource.ModelType? {
       let request = try await self.setRequestMethodAndHeaders(endpoint:self.endpoint)
       return try await self.request(request, payload: nil)
    }
    
    func executeRequestWithPayload(_ payload:Data?) async throws -> Resource.ModelType? {
        var request = try await self.setRequestMethodAndHeaders(endpoint: self.endpoint)
        request.httpBody = payload
        return try await self.request(request, payload: payload)
    }
}

struct AuthRequest<Resource: TokenPostEndpoint> {
    let endpoint: Resource
}

extension AuthRequest: NetworkRequest {
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let wrapper = try? decoder.decode(Resource.ModelType.self, from: data)
        return wrapper
    }
    
    func setRequestMethodAndHeaders<T>(endpoint: T) async throws -> URLRequest where T: Endpoint {
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = endpoint.method.rawValue
        //authorization isn't needed for this type of request
        urlRequest.setValue(PayloadEncodingMethod.formUrl.rawValue, forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    func executeRequest() async throws -> Resource.ModelType? {
        let request = try await self.setRequestMethodAndHeaders(endpoint: self.endpoint)
        return try await self.request(request, payload: nil)
    }
    func executeRequestWithPayload(_ payload:Data?) async throws -> Resource.ModelType? {
        var request = try await self.setRequestMethodAndHeaders(endpoint: self.endpoint)
        request.httpBody = payload
        return try await self.request(request, payload: payload)
    }

}
