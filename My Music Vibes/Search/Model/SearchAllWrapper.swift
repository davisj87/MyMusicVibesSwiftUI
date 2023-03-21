//
//  SearchAllWrapper.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct SearchAllWrapper: Decodable {
    var tracks: ItemsWrapper<TracksObject>
    var albums: ItemsWrapper<AlbumObject>
    var artists: ItemsWrapper<ArtistObject>
    var playlists: ItemsWrapper<PlaylistObject>
    
    private enum CodingKeys: String, CodingKey {
        case tracks, albums, artists, playlists
    }
}

extension SearchAllWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tracks = try container.decodeIfPresent(ItemsWrapper.self, forKey: .tracks) ?? ItemsWrapper(items: [], total:0)
        self.albums = try container.decodeIfPresent(ItemsWrapper.self, forKey: .albums) ?? ItemsWrapper(items: [], total:0)
        self.artists = try container.decodeIfPresent(ItemsWrapper.self, forKey: .artists) ?? ItemsWrapper(items: [], total:0)
        self.playlists = try container.decodeIfPresent(ItemsWrapper.self, forKey: .playlists) ?? ItemsWrapper(items: [], total:0)
    }
}
