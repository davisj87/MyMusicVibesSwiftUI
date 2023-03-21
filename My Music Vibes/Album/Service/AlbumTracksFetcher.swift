//
//  AlbumTracksFetcher.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol AlbumTracksFetcherProtocol {
    func getAlbumTracksIds(albumId:String) async throws -> String
    func getTracks(ids:String) async throws -> [TracksObject]
    func getTracksDetails(ids:String) async throws -> Set<TrackFeaturesObject?>
}

struct AlbumTracksFetcher:AlbumTracksFetcherProtocol {
    private let authManager = AuthManager()
    func getAlbumTracksIds(albumId:String) async throws -> String {
        let albumTracksEndpoint = AlbumTracksEndpoint(id: albumId)
        let albumTracksRequest = APIRequest(endpoint: albumTracksEndpoint, authManager: authManager)
        guard let albumTracks = try await albumTracksRequest.executeRequest() else { return "" }
        let trackIds = albumTracks.items.map{ $0.id }
        let trackIdsString = trackIds.joined(separator: ",")
        print(trackIdsString)
        return trackIdsString
    }

    func getTracksDetails(ids:String) async throws -> Set<TrackFeaturesObject?> {
        let tracksDetailsEndpoint = TracksDetailEndpoint(ids: ids)
        let tracksDetailsRequest = APIRequest(endpoint: tracksDetailsEndpoint, authManager: authManager)
        guard let trackDetails = try await tracksDetailsRequest.executeRequest() else { return [] }
        return trackDetails.audioFeatures
    }
    
    func getTracks(ids:String) async throws -> [TracksObject] {
        let tracksArrEndpoint = TracksArrayEndpoint(ids: ids)
        let tracksArrRequest = APIRequest(endpoint: tracksArrEndpoint, authManager: authManager)
        guard let tracksArr = try await tracksArrRequest.executeRequest() else { return [] }
        return tracksArr.tracks
    }
}

