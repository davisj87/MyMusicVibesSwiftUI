//
//  AlbumListWrapper.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct AlbumWrapper: Decodable {
    var albums: ItemsWrapper<AlbumObject>
    
    private enum CodingKeys: String, CodingKey {
        case albums
    }
}

extension AlbumWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albums = try container.decodeIfPresent(ItemsWrapper.self, forKey: .albums) ?? ItemsWrapper(items: [], total:0)
    }
}
