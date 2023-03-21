//
//  AlbumObject.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct AlbumObject:Decodable {
    var id: String
    var artists:[AlbumArtistObject]
    var images:[ImageObject]
    var name:String
    var releaseDate:String
    
    private enum CodingKeys: String, CodingKey {
        case id, artists, images,
             name
        case releaseDate = "release_date"
    }
}

extension AlbumObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.artists = try container.decodeIfPresent([AlbumArtistObject].self, forKey: .artists) ?? []
        self.images = try container.decodeIfPresent([ImageObject].self, forKey: .images) ?? []
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? "N/A"
        
        
    }
}

struct AlbumArtistObject:Decodable  {
    var id:String
    var name:String
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}

extension AlbumArtistObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
    }
}
