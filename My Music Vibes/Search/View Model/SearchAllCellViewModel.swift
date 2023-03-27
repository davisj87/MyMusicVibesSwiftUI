//
//  SearchAllCellViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation


protocol SearchOverviewCellViewModelProtocol: ItemOverviewCellViewModelProtocol {
    var searchType:SearchType { get }
}

struct OverviewCellViewModel: SearchOverviewCellViewModelProtocol {
    var searchType: SearchType
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var popularity: String
    var imageUrl: String
    var id: String
    
    init<T:SearchOverviewCellViewModelProtocol>(model:T) {
        primaryText = model.primaryText
        secondaryText = model.secondaryText
        additionalDetailText = model.additionalDetailText
        popularity = model.popularity
        imageUrl = model.imageUrl
        id = model.id
        searchType = model.searchType
    }
    
}

struct SearchAllCellViewModel: SearchOverviewCellViewModelProtocol {
    var searchType: SearchType
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String = ""
    var popularity: String = ""
    var imageUrl:String = ""
    var id:String
    
    init(albumObject:AlbumObject) {
        self.id = albumObject.id
        self.primaryText = albumObject.name
        self.secondaryText = albumObject.artists.isEmpty ? "Album" : "Album | " + albumObject.artists[0].name
        self.imageUrl = albumObject.images.isEmpty ? "" : albumObject.images[0].url
        self.searchType = .album
    }
    
    init(artistsObject: ArtistObject) {
        self.id = artistsObject.id
        self.primaryText = artistsObject.name
        self.secondaryText = "Artist"
        self.imageUrl = artistsObject.images.isEmpty ? "" : artistsObject.images[0].url
        self.searchType = .artist
    }
    
    init(tracksObject: TracksObject) {
        self.id = tracksObject.id
        self.primaryText = tracksObject.name
        self.secondaryText = tracksObject.artists.isEmpty ? "Song" : "Song | " + tracksObject.artists[0].name
        self.imageUrl = tracksObject.album.images.isEmpty ? "" : tracksObject.album.images[0].url
        self.searchType = .track
    }
    
    init(playlistObject: PlaylistObject) {
        self.id = playlistObject.id
        self.primaryText = playlistObject.name
        self.secondaryText = "Playlist | " + playlistObject.owner.name
        self.imageUrl = playlistObject.images.isEmpty ? "" : playlistObject.images[0].url
        self.searchType = .playlist
    }
}

