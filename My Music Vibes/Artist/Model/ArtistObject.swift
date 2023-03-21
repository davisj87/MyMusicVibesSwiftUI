//
//  ArtistObject.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct ArtistObject: Decodable {
    var id: String
    var name: String
    var genres: [String]
    var followers: ArtistFollowersObject
    var images: [ImageObject]
    var popularity: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, name, genres, followers, images, popularity
    }
}


extension ArtistObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        self.genres = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
        self.followers = try container.decodeIfPresent(ArtistFollowersObject.self, forKey: .followers) ?? ArtistFollowersObject(total: -1)
        self.images = try container.decodeIfPresent([ImageObject].self, forKey: .images) ?? []
        self.popularity = try container.decodeIfPresent(Int.self, forKey: .popularity) ?? -1
    }
}


struct ArtistFollowersObject: Decodable {
    var total: Int
    
    private enum CodingKeys: String, CodingKey {
        case total
    }
}

extension ArtistFollowersObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total) ?? -1
    }
}


