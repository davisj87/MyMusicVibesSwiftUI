//
//  PlaylistTracksFetcher.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol PlaylistTracksFetcherProtocol {
    func getTracks(playlistId:String) async throws -> [PlaylistTrackObject]
    func getTracksDetails(tracks:[PlaylistTrackObject]) async throws -> Set<TrackFeaturesObject?>
}

struct PlaylistTracksFetcher:PlaylistTracksFetcherProtocol {
    private let authManager = AuthManager()
    func getTracks(playlistId: String) async throws -> [PlaylistTrackObject] {
        let playlistTracksEndpoint = PlaylistTracksEndpoint(id: playlistId)
        let playlistTracksRequest = APIRequest(endpoint: playlistTracksEndpoint, authManager: authManager)
        guard let playlistTracks = try await playlistTracksRequest.executeRequest() else { return []}
        return playlistTracks.items
    }
    
   func getTracksDetails(tracks:[PlaylistTrackObject]) async throws -> Set<TrackFeaturesObject?> {
        let trackIds = tracks.map{ $0.track.id }
        let trackIdsString = trackIds.joined(separator: ",")
        let tracksDetailsEndpoint = TracksDetailEndpoint(ids: trackIdsString)
        
        let tracksDetailsRequest = APIRequest(endpoint: tracksDetailsEndpoint, authManager: authManager)
        guard let trackDetails = try await tracksDetailsRequest.executeRequest() else { return [] }
        return trackDetails.audioFeatures
    }
}
