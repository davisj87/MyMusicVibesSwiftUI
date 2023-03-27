//
//  PlaylistTracksViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

final class PlaylistTracksViewModel: TrackDetailViewFormatter {
    private (set) var playlistTracks:[PlaylistTrackObject] = []
    private (set) var trackDetailsArr = Set<TrackFeaturesObject?>()
    
    var trackCount:Int {
        return playlistTracks.count
    }
    
    func getTrackAndDetailsVM(at index:Int) -> TrackDetailTableViewCellViewModel {
        let playlistTrack = playlistTracks[index]
        let trackCellViewModel = TrackOverviewCellViewModel(tracksObject: playlistTracks[index].track)
        if let detailIndex = trackDetailsArr.firstIndex(of: TrackFeaturesObject(withId: playlistTrack.track.id)) {
            return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: trackDetailsArr[detailIndex])
        }
        return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: nil)
    }
     
    let playlist:any ItemOverviewCellViewModelProtocol
    let playlistTracksFetcher:PlaylistTracksFetcherProtocol
    
    init(playlist:any ItemOverviewCellViewModelProtocol, playlistTracksFetcher:PlaylistTracksFetcherProtocol = PlaylistTracksFetcher()) {
        self.playlist = playlist
        self.playlistTracksFetcher = playlistTracksFetcher
    }
    
    func getTracks() async throws {
        self.playlistTracks = try await self.playlistTracksFetcher.getTracks(playlistId: self.playlist.id)
        self.trackDetailsArr = try await self.playlistTracksFetcher.getTracksDetails(tracks: self.playlistTracks)
    }
}

