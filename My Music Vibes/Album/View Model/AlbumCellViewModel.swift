//
//  AlbumCellViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct AlbumOverviewCellViewModel: SearchOverviewCellViewModelProtocol {
    var searchType: SearchType = .album
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String = ""
    var popularity: String = ""
    var imageUrl:String = ""
    var id:String
    
    init(albumObject:AlbumObject) {
        self.id = albumObject.id
        self.primaryText = albumObject.name
        self.secondaryText = albumObject.artists.isEmpty ? "" : albumObject.artists[0].name
        self.additionalDetailText = albumObject.releaseDate
        self.imageUrl = albumObject.images.isEmpty ? "" : albumObject.images[0].url
    }
}

extension AlbumOverviewCellViewModel: Hashable {
    static func == (lhs: AlbumOverviewCellViewModel, rhs: AlbumOverviewCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
