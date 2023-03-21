//
//  HomeFetcher.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol HomeFetcherProtocol {
    func getTopArtists() async throws -> [ArtistObject]
    func getTopTracks() async throws -> [TracksObject]
    func getTopPlaylists() async throws -> [PlaylistObject]
}

struct HomeFetcher:HomeFetcherProtocol {
    private let authManager = AuthManager()
    func getTopArtists() async throws -> [ArtistObject] {
        let topArtistsEndpoint = TopArtistsEndpoint()
        let topArtistsRequest = APIRequest(endpoint: topArtistsEndpoint, authManager: authManager)
        guard let topArtistsWrapper = try await topArtistsRequest.executeRequest() else { return [] }
        return topArtistsWrapper.items
    }
    
    func getTopTracks() async throws -> [TracksObject] {
        let topTracksEndpoint = TopTracksEndpoint()
        let topTracksRequest = APIRequest(endpoint: topTracksEndpoint, authManager: authManager)
        guard let topTracksWrapper = try await topTracksRequest.executeRequest() else { return [] }
        return topTracksWrapper.items
    }
    
    func getTopPlaylists() async throws -> [PlaylistObject] {
        let topPlaylistsEndpoint = TopPlaylistsEndpoint()
        let topPlaylistsRequest = APIRequest(endpoint: topPlaylistsEndpoint, authManager: authManager)
        guard let topPlaylistsWrapper = try await topPlaylistsRequest.executeRequest() else { return [] }
        return topPlaylistsWrapper.items
    }
}
