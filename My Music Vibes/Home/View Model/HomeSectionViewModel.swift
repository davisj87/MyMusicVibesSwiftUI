//
//  HomeSectionViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

enum HomeSectionViewModelScope:String {
    case artist = "Artist"
    case track = "Track"
    case playlist = "Playlist"
}


struct HomeArtistSectionViewModel {
    var title:String = "Artists"
    var homeCells:[ArtistOverviewCellViewModel]
}

struct HomePlaylistSectionViewModel {
    var title:String = "Playlists"
    var homeCells:[PlaylistOverviewCellViewModel]
}

struct HomeTrackSectionViewModel {
    var title:String = "Tracks"
    var homeCells:[TrackOverviewCellViewModel]
}


//struct HomeSectionViewModel<T:ItemOverviewCellViewModelProtocol>:Identifiable {
//    var id = UUID()
//    var title:HomeSectionViewModelScope
//    var homeCells:[T]
//}


//struct HomeCellViewModel: ItemOverviewCellViewModelProtocol {
//    var primaryText: String
//    var secondaryText: String
//    var additionalDetailText: String
//    var popularity: String
//    var imageUrl: String
//    var id: String
//
//    init(tracksObject: TracksObject) {
//        self.id = tracksObject.id
//        self.primaryText = tracksObject.name
//        self.secondaryText = tracksObject.artists.isEmpty ? "" : tracksObject.artists[0].name
//        self.additionalDetailText = tracksObject.album.name
//        self.popularity = String(tracksObject.popularity)
//        self.imageUrl = tracksObject.album.images.isEmpty ? "" : tracksObject.album.images[0].url
//    }
//
//    init(artistsObject: ArtistObject) {
//        self.id = artistsObject.id
//        self.primaryText = artistsObject.name
//        self.secondaryText = ""
//        if !artistsObject.genres.isEmpty {
//            let genres = artistsObject.genres.joined(separator: ", ")
//            self.secondaryText = genres
//        }
//        self.additionalDetailText = String(artistsObject.followers.total)
//        self.popularity = String(artistsObject.popularity)
//        self.imageUrl = artistsObject.images.isEmpty ? "" : artistsObject.images[0].url
//    }
//
//    init(playlistObject: PlaylistObject) {
//        self.id = playlistObject.id
//        self.primaryText = playlistObject.name
//        self.secondaryText = playlistObject.owner.name
//        self.additionalDetailText = ""
//        self.popularity = ""
//        self.imageUrl = playlistObject.images.isEmpty ? "" : playlistObject.images[0].url
//    }
//}
//
//extension HomeCellViewModel: Hashable {
//    static func == (lhs: HomeCellViewModel, rhs: HomeCellViewModel) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
