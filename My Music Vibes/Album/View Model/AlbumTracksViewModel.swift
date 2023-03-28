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
    
    
    @Published var state: ViewModelState = .loading
    
   // private var trackDetailsCellViewModels:[TrackDetailTableViewCellViewModel] = []
    
    var trackRange:Range<Int>  {
        return tracks.indices
    }
    
    func getTrackAndDetailsVM(at index:Int) -> TrackDetailTableViewCellViewModel {
        let track = tracks[index]
        let trackCellViewModel = TrackOverviewCellViewModel(tracksObject: track)
        if let detailIndex = trackDetails.firstIndex(of: TrackFeaturesObject(withId: track.id)) {
            return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: trackDetails[detailIndex])
        }
        return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: nil)
    }
    
    private let albumTracksFetcher:AlbumTracksFetcherProtocol
    let album:any ItemOverviewCellViewModelProtocol
    
    init(album:some ItemOverviewCellViewModelProtocol, albumTracksFetcher:AlbumTracksFetcherProtocol = AlbumTracksFetcher()) {
        self.album = album
        self.albumTracksFetcher = albumTracksFetcher
    }
    
    func getTracks() async throws {
        self.tracks = []
        self.trackDetails = []
        do {
            let trackIdsString = try await self.albumTracksFetcher.getAlbumTracksIds(albumId: self.album.id)
            async let trackArr = self.albumTracksFetcher.getTracks(ids: trackIdsString)
            async let trackDetailsArr = self.albumTracksFetcher.getTracksDetails(ids: trackIdsString)
            let result = try await TrackAndDetailsResponse(tracks: trackArr, trackDetails: trackDetailsArr)
            self.tracks = result.tracks
            self.trackDetails = result.trackDetails
            
            if tracks.isEmpty {
                state = .empty("This album has no tracks.")
            } else {
                state = .loaded
            }
            
        } catch {
            state = .error("There was an error loading your data")
        }
        
//        self.trackDetailsCellViewModels = result.tracks.map { eachTrack in
//            let trackCellViewModel = TrackOverviewCellViewModel(tracksObject: eachTrack)
//            if let trackDetailIndex = result.trackDetails.firstIndex(of: TrackFeaturesObject(withId: eachTrack.id)) {
//                return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: result.trackDetails[trackDetailIndex])
//            }
//            return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: nil)
//        }
    }
}

fileprivate struct TrackAndDetailsResponse {
    var tracks:[TracksObject]
    var trackDetails:Set<TrackFeaturesObject?>
}
