//
//  ArtistListWrapper.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct ArtistWrapper: Decodable {
    var artists: ItemsWrapper<ArtistObject>
    
    private enum CodingKeys: String, CodingKey {
        case artists
    }
}

extension ArtistWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artists = try container.decodeIfPresent(ItemsWrapper.self, forKey: .artists) ?? ItemsWrapper(items: [], total:0)
    }
}
