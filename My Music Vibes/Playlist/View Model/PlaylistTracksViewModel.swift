//
//  PlaylistTracksViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

@MainActor final class PlaylistTracksViewModel: ObservableObject {
    private (set) var playlistTracks:[PlaylistTrackObject] = []
    private (set) var trackDetails = Set<TrackFeaturesObject?>()
    
    @Published var state: ViewModelState = .loading
    
    var trackRange:Range<Int>  {
        return playlistTracks.indices
    }
    
    func getTrackAndDetailsVM(at index:Int) -> TrackDetailTableViewCellViewModel {
        let playlistTrack = playlistTracks[index]
        let trackCellViewModel = TrackOverviewCellViewModel(tracksObject: playlistTracks[index].track)
        if let detailIndex = trackDetails.firstIndex(of: TrackFeaturesObject(withId: playlistTrack.track.id)) {
            return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: trackDetails[detailIndex])
        }
        return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: nil)
    }
     
    let playlist:any ItemOverviewCellViewModelProtocol
    let playlistTracksFetcher:PlaylistTracksFetcherProtocol
    
    init(playlist:some ItemOverviewCellViewModelProtocol, playlistTracksFetcher:PlaylistTracksFetcherProtocol = PlaylistTracksFetcher()) {
        self.playlist = playlist
        self.playlistTracksFetcher = playlistTracksFetcher
    }
    
    func getTracks() async throws {
        self.playlistTracks = []
        self.trackDetails = []
        do {
            self.playlistTracks = try await self.playlistTracksFetcher.getTracks(playlistId: self.playlist.id)
            self.trackDetails = try await self.playlistTracksFetcher.getTracksDetails(tracks: self.playlistTracks)
            if playlistTracks.isEmpty {
                state = .empty("This playlist has no tracks.")
            } else {
                state = .loaded
            }
        } catch {
            state = .error("There was an error loading your data")
        }
    }
}

