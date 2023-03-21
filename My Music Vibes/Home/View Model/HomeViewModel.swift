//
//  HomeViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

@MainActor final class HomeViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded(tracks:[TrackOverviewCellViewModel],artists:[ArtistOverviewCellViewModel], playlists: [PlaylistOverviewCellViewModel])
        case empty(String)
        case error(String)
    }
    
    private let authManager = AuthManager()
    
    @Published var state: State = .loading
    
    let homeFetcher: HomeFetcherProtocol
    
    init(homeFetcher: some HomeFetcherProtocol = HomeFetcher()) {
        self.homeFetcher = homeFetcher
    }
    
    func loadTopItems() async throws {
        async let tracks = self.homeFetcher.getTopTracks()
        async let artists = self.homeFetcher.getTopArtists()
        async let playlists = self.homeFetcher.getTopPlaylists()
        
        do {
            let sections = try await self.mapSections(tracks: tracks, artists: artists, playlist: playlists)
            if sections.tracksCellVM.isEmpty && sections.artistCellVM.isEmpty && sections.playlistCellVM.isEmpty {
                state = .empty("You currently have no favorites")
            } else {
                state = .loaded(tracks: sections.tracksCellVM, artists: sections.artistCellVM, playlists: sections.playlistCellVM)
            }
        } catch {
            state = .error("There was an error loading your data")
        }
    }
    
    private func mapSections(tracks:[TracksObject], artists:[ArtistObject], playlist: [PlaylistObject]) -> (tracksCellVM:[TrackOverviewCellViewModel], artistCellVM:[ArtistOverviewCellViewModel], playlistCellVM:[PlaylistOverviewCellViewModel]) {
        let tracksViewModel = tracks.map{ TrackOverviewCellViewModel(tracksObject: $0) }
        let artistViewModel = artists.map{ ArtistOverviewCellViewModel(artistsObject: $0) }
        let playlistViewModel = playlist.map{ PlaylistOverviewCellViewModel(playlistObject: $0) }
    
        return (tracksCellVM:tracksViewModel, artistCellVM:artistViewModel, playlistCellVM:playlistViewModel)
    }
}




