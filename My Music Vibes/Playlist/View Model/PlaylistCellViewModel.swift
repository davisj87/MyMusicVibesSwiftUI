//
//  PlaylistCellViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct PlaylistOverviewCellViewModel: ItemOverviewCellViewModelProtocol {
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var popularity: String = ""
    var imageUrl: String
    var id: String
    
    init(playlistObject: PlaylistObject) {
        self.id = playlistObject.id
        self.primaryText = playlistObject.name
        self.secondaryText = playlistObject.owner.name
        self.additionalDetailText = ""
        self.imageUrl = playlistObject.images.isEmpty ? "" : playlistObject.images[0].url
    }
}

extension PlaylistOverviewCellViewModel: Hashable {
    static func == (lhs: PlaylistOverviewCellViewModel, rhs: PlaylistOverviewCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


