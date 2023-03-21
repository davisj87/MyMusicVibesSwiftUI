//
//  TrackDetailFetcher.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol TrackDetailFetcherProtcol {
    func getTrackDetails(trackId:String) async throws -> TrackFeaturesObject?
}

struct TrackDetailFetcher: TrackDetailFetcherProtcol {
    private let authManager = AuthManager()
    func getTrackDetails(trackId:String) async throws -> TrackFeaturesObject? {
        let singleTracksEndpoint = SingleTrackDetailEndpoint(id:trackId)
        let singleTracksRequest = APIRequest(endpoint: singleTracksEndpoint, authManager: authManager)
        print("get tracks details")
        guard let trackDetails = try await singleTracksRequest.executeRequest() else { return nil }
        return trackDetails
    }
}
