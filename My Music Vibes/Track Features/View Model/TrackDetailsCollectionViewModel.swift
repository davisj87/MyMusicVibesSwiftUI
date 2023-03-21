//
//  TrackDetailsCollectionViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

final class TrackDetailsCollectionViewModel: TrackDetailViewFormatter {
    private (set) var trackSectionViewModel:[TrackCollectionViewSectionViewModel] = []
    private (set) var track:ItemOverviewCellViewModelProtocol
    private var trackDetail:TrackFeaturesObject?
    
    private let trackDetailFetcher: TrackDetailFetcherProtcol
    
    init(track:ItemOverviewCellViewModelProtocol,
         trackDetail:TrackFeaturesObject? = nil,
         trackDetailFetcher:TrackDetailFetcherProtcol = TrackDetailFetcher()) {
        
        self.track = track
        self.trackDetail = trackDetail
        self.trackDetailFetcher = trackDetailFetcher
    }
    
    
    func getTrack() async throws {
        if let trackDetail = self.trackDetail {
            print("used preloaded track details")
            self.trackSectionViewModel = self.setupCollectionViewModel(trackDetails: trackDetail)
        } else {
            guard let trackDetailData = try await self.trackDetailFetcher.getTrackDetails(trackId: self.track.id) else { return }
            self.trackSectionViewModel = self.setupCollectionViewModel(trackDetails: trackDetailData)
        }
    }
    
    private func setupCollectionViewModel(trackDetails:TrackFeaturesObject) -> [TrackCollectionViewSectionViewModel] {
        print("setup detail view model")
        //Mood Section: Danceability, Valence, Energy, Tempo
        let danceability = TrackCollectionViewCellViewModel(name: "Danceability", value: String(Int(trackDetails.danceability)))
        
        let valenceString = self.intValencetoString(valence: trackDetails.valence)
        let valence = TrackCollectionViewCellViewModel(name: "Musical Vibe", value: valenceString)
        let energy = TrackCollectionViewCellViewModel(name: "Energy", value: String(Int(trackDetails.energy)))
        let tempo = TrackCollectionViewCellViewModel(name: "Tempo", value: String(Int(trackDetails.tempo)))
        let moodArray = [danceability, valence, energy, tempo]
        let moodSection = TrackCollectionViewSectionViewModel(title: "Mood", attributes: moodArray)
        
        //Properties: Loudness, Speechiness, Instrumentalness, Key, Mode
        let keyString = self.intKeytoString(key: trackDetails.key)
        let modeString = self.intModetoString(mode: trackDetails.mode)
        let keyMode = TrackCollectionViewCellViewModel(name: "Key", value: keyString + " " + modeString)
        let loudness = TrackCollectionViewCellViewModel(name: "Loudness", value: String(trackDetails.loudness))
        let speechiness = TrackCollectionViewCellViewModel(name: "Speechiness", value: String(Int(trackDetails.speechiness)))
        let instrumentalness = TrackCollectionViewCellViewModel(name: "Instrumentalness", value: String(Int(trackDetails.instrumentalness)))
        let propArray = [keyMode, loudness, speechiness, instrumentalness]
        let propSection = TrackCollectionViewSectionViewModel(title: "Properties", attributes: propArray)
        
        //Context: Liveness, Acousticness
        let liveness = TrackCollectionViewCellViewModel(name: "Liveness", value: String(Int(trackDetails.liveness)))
        let acousticness = TrackCollectionViewCellViewModel(name: "Acousticness", value: String(Int(trackDetails.acousticness)))
        let contextArray = [liveness, acousticness]
        let contextSection = TrackCollectionViewSectionViewModel(title: "Context", attributes: contextArray)
        
        let sections = [moodSection, propSection, contextSection]
        return sections
    }
    
}

struct TrackCollectionViewSectionViewModel {
    var title: String
    var attributes: [TrackCollectionViewCellViewModel]
}

struct TrackCollectionViewCellViewModel {
    var name: String
    var value: String
}




