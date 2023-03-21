//
//  PlaylistObject.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct PlaylistObject: Decodable {
    var id: String
    var name: String
    var owner: PlaylistOwnerObject
    var images: [ImageObject]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, owner, images
    }
    
}

extension PlaylistObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        self.owner = try container.decodeIfPresent(PlaylistOwnerObject.self, forKey: .owner) ?? PlaylistOwnerObject(name: "N/A")
        self.images = try container.decodeIfPresent([ImageObject].self, forKey: .images) ?? []
    }
}

struct PlaylistOwnerObject: Decodable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "display_name"
    }
}

extension PlaylistOwnerObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
    }
}
