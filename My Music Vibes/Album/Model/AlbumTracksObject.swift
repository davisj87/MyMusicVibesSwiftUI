//
//  AlbumTracksObject.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct AlbumTracksObject: Decodable {
    var id: String
    var artists:[AlbumArtistObject]
    var name:String
    var trackNumber:Int
    
    private enum CodingKeys: String, CodingKey {
        case id, artists, name
        case trackNumber = "track_number"
    }
    
}

extension AlbumTracksObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.artists = try container.decodeIfPresent([AlbumArtistObject].self, forKey: .artists) ?? []
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        self.trackNumber = try container.decodeIfPresent(Int.self, forKey: .trackNumber) ?? -1
    }
}
