//
//  HomeViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

@MainActor final class HomeViewModel: ObservableObject {
    
    private var tracks:[TracksObject] = []
    private var artists:[ArtistObject] = []
    private var playlists:[PlaylistObject] = []
    
    var trackRange:Range<Int> {
        return tracks.indices
    }
    
    var artistRange:Range<Int> {
        return artists.indices
    }
    
    var playlistRange:Range<Int> {
        return playlists.indices
    }
    
    private let authManager = AuthManager()
    
    @Published var state: ViewModelState = .loading
    
    let homeFetcher: HomeFetcherProtocol
    
    init(homeFetcher: some HomeFetcherProtocol = HomeFetcher()) {
        self.homeFetcher = homeFetcher
    }
    
    func loadTopItems() async throws {
        self.reset()
        async let tracks = self.homeFetcher.getTopTracks()
        async let artists = self.homeFetcher.getTopArtists()
        async let playlists = self.homeFetcher.getTopPlaylists()
        
        do {
            try await self.setSections(tracks: tracks, artists: artists, playlists: playlists)
            if self.tracks.isEmpty && self.artists.isEmpty && self.playlists.isEmpty {
                state = .empty("You currently have no favorites")
            } else {
                state = .loaded
            }
        } catch {
            state = .error("There was an error loading your data")
        }
    }
    
    func getPlaylistCellViewModel(at index:Int) -> PlaylistOverviewCellViewModel {
        return PlaylistOverviewCellViewModel(playlistObject: playlists[index])
    }
    
    func getArtistCellViewModel(at index:Int) -> ArtistOverviewCellViewModel {
        return ArtistOverviewCellViewModel(artistsObject: artists[index])
    }
    
    func getTrackCellViewModel(at index:Int) -> TrackOverviewCellViewModel {
        return TrackOverviewCellViewModel(tracksObject: tracks[index])
    }
    
    private func setSections(tracks:[TracksObject], artists:[ArtistObject], playlists: [PlaylistObject]) {
        self.tracks = tracks
        self.artists = artists
        self.playlists = playlists
    }
    
    private func reset() {
        self.playlists = []
        self.tracks = []
        self.artists = []
    }
}




