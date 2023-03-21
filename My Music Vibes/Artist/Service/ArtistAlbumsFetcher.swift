//
//  ArtistAlbumsFetcher.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol ArtistAlbumsFetcherProtocol {
    func getAlbumsFromArtist(artistId:String) async throws -> (total:Int, items:[AlbumObject])
    func getMoreAlbumsFromArtist(artistId:String, offset:Int) async throws -> [AlbumObject]
}

struct ArtistAlbumsFetcher:ArtistAlbumsFetcherProtocol {
    private let authManager = AuthManager()
    
    func getAlbumsFromArtist(artistId:String) async throws -> (total:Int, items:[AlbumObject]) {
        let artistAlbumsEndpoint = ArtistAlbumsEndpoint(id: artistId, limit: 20, offset: 0)
        let artistAlbumsRequest = APIRequest(endpoint: artistAlbumsEndpoint, authManager: authManager)
        guard let artistAlbums = try await artistAlbumsRequest.executeRequest(),
                artistAlbums.total > 0 else { return (total:0, items:[])}
        return (total:artistAlbums.total, items:artistAlbums.items)
    }
    
    func getMoreAlbumsFromArtist(artistId:String, offset:Int) async throws -> [AlbumObject] {
        let artistAlbumsEndpoint = ArtistAlbumsEndpoint(id: artistId, limit: 20, offset: offset)
        let artistAlbumsRequest = APIRequest(endpoint: artistAlbumsEndpoint, authManager: authManager)
        guard let artistAlbums = try await artistAlbumsRequest.executeRequest(), artistAlbums.total > 0 else { return []}
        return artistAlbums.items
    }
}
