//
//  ObjectItemWrapper.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

struct ObjectItemWrapper<T: Decodable>: Decodable {
    let items: [T]
    let total: Int
    
    private enum CodingKeys: String, CodingKey {
        case items, total
    }
}

extension ObjectItemWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decodeIfPresent([T].self, forKey: .items) ?? []
        self.total = try container.decodeIfPresent(Int.self, forKey: .total) ?? 0
    }
}
