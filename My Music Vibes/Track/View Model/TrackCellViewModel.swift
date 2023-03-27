//
//  TrackCellViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct TrackOverviewCellViewModel: SearchOverviewCellViewModelProtocol {
    var searchType: SearchType = .track
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String = ""
    var popularity: String
    var imageUrl: String
    var id: String
    
    init(tracksObject: TracksObject) {
        self.id = tracksObject.id
        self.primaryText = tracksObject.name
        self.secondaryText = tracksObject.artists.isEmpty ? "" : tracksObject.artists[0].name
        self.additionalDetailText = tracksObject.album.name
        self.popularity = String(tracksObject.popularity)
        self.imageUrl = tracksObject.album.images.isEmpty ? "" : tracksObject.album.images[0].url
    }
}

extension TrackOverviewCellViewModel: Hashable {
    static func == (lhs: TrackOverviewCellViewModel, rhs: TrackOverviewCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
