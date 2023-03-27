//
//  ArtistCellViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct ArtistOverviewCellViewModel: SearchOverviewCellViewModelProtocol {
    var searchType: SearchType = .artist
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String = ""
    var popularity: String
    var imageUrl: String
    var id: String
    
    init(artistsObject: ArtistObject) {
        self.id = artistsObject.id
        self.primaryText = artistsObject.name
        self.secondaryText = ""
        if !artistsObject.genres.isEmpty {
            let genres = artistsObject.genres.joined(separator: ", ")
            self.secondaryText = genres
        }
        self.additionalDetailText = "Followers: " + String(artistsObject.followers.total)
        self.popularity = String(artistsObject.popularity)
        self.imageUrl = artistsObject.images.isEmpty ? "" : artistsObject.images[0].url
    }
}

extension ArtistOverviewCellViewModel: Hashable {
    static func == (lhs: ArtistOverviewCellViewModel, rhs: ArtistOverviewCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

