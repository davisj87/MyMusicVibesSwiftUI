//
//  AlbumTracksViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

@MainActor final class AlbumTracksViewModel: ObservableObject {
    private (set) var tracks:[TracksObject] = []
    private (set) var trackDetails = Set<TrackFeaturesObject?>()
    @Published private (set) var trackDetailsCellViewModels:[TrackDetailTableViewCellViewModel] = []
    
    private let albumTracksFetcher:AlbumTracksFetcherProtocol
    let album:AlbumOverviewCellViewModel
    
    init(album:AlbumOverviewCellViewModel, albumTracksFetcher:AlbumTracksFetcherProtocol = AlbumTracksFetcher()) {
        self.album = album
        self.albumTracksFetcher = albumTracksFetcher
    }
    
    func getTracksData() async throws {
        let trackIdsString = try await self.albumTracksFetcher.getAlbumTracksIds(albumId: self.album.id)
        async let trackArr = self.albumTracksFetcher.getTracks(ids: trackIdsString)
        async let trackDetailsArr = self.albumTracksFetcher.getTracksDetails(ids: trackIdsString)
        let result = try await TrackAndDetailsResponse(tracks: trackArr, trackDetails: trackDetailsArr)
        self.tracks = result.tracks
        self.trackDetails = result.trackDetails
        
        self.trackDetailsCellViewModels = result.tracks.map { eachTrack in
            let trackCellViewModel = TrackOverviewCellViewModel(tracksObject: eachTrack)
            if let trackDetailIndex = result.trackDetails.firstIndex(of: TrackFeaturesObject(withId: eachTrack.id)) {
                return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: result.trackDetails[trackDetailIndex])
            }
            return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: nil)
        }
    }
}

fileprivate struct TrackAndDetailsResponse {
    var tracks:[TracksObject]
    var trackDetails:Set<TrackFeaturesObject?>
}
