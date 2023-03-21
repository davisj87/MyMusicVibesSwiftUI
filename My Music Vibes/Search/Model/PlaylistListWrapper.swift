//
//  PlaylistListWrapper.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct PlaylistWrapper: Decodable {
    var playlists: ItemsWrapper<PlaylistObject>
    
    private enum CodingKeys: String, CodingKey {
        case playlists
    }
}

extension PlaylistWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.playlists = try container.decodeIfPresent(ItemsWrapper.self, forKey: .playlists) ?? ItemsWrapper(items: [], total:0)
    }
}
