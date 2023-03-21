//
//  PlaylistTrackObject.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct PlaylistTrackObject: Codable {
    var track: TracksObject
    
    private enum CodingKeys: String, CodingKey {
        case track
    }
}


extension PlaylistTrackObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let emptyTrackAlbumObject = TrackAlbumObject(images: [], name: "N/A")
        self.track = try container.decodeIfPresent(TracksObject.self, forKey: .track) ?? TracksObject(id: "",
                                                                                                      name: "N/A",
                                                                                                      popularity: -1,
                                                                                                      album: emptyTrackAlbumObject,
                                                                                                      artists: [])
    }
}
