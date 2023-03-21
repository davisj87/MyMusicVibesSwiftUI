//
//  SearchFetcher.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol SearchFetcherProtocol {
    func getAll(query:String) async throws -> [SearchAllCellViewModel]
    func getAlbum(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[AlbumOverviewCellViewModel])
    func getArtists(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[ArtistOverviewCellViewModel])
    func getPlaylists(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[PlaylistOverviewCellViewModel])
    func getTracks(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[TrackOverviewCellViewModel])
}

struct SearchFetcher:SearchFetcherProtocol {
    private let authManager = AuthManager()
    
    func getAll(query:String) async throws -> [SearchAllCellViewModel] {
        let searchAllEndpoint = SearchAllEndpoint(searchString: query)
        let searchAllRequest = APIRequest(endpoint: searchAllEndpoint, authManager: authManager)
        guard let searchAllResults = try await searchAllRequest.executeRequest() else { return []}
        
        let albums = searchAllResults.albums.items
        let albumCellVM = albums.map{ SearchAllCellViewModel(albumObject: $0) }
        
        let playlists = searchAllResults.playlists.items
        let playlistCellVM = playlists.map{ SearchAllCellViewModel(playlistObject: $0) }
        
        let tracks = searchAllResults.tracks.items
        let tracksCellVM = tracks.map{ SearchAllCellViewModel(tracksObject: $0) }
        
        let artists = searchAllResults.artists.items
        let artistCellVM = artists.map{ SearchAllCellViewModel(artistsObject:$0) }
        
        return albumCellVM + playlistCellVM + tracksCellVM + artistCellVM
    }
    
    func getAlbum(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[AlbumOverviewCellViewModel]) {
        let searchAlbumEndpoint = SearchAlbumEndpoint(searchString: query, limit: limit, offset: offset)
        let searchAlbumRequest = APIRequest(endpoint: searchAlbumEndpoint, authManager: authManager)
        guard let searchAlbumResults = try await searchAlbumRequest.executeRequest() else { return (scopeTotal:0, items:[])}
        let albums = searchAlbumResults.albums.items
        let albumsViewModelArr = albums.map{ AlbumOverviewCellViewModel(albumObject: $0) }
        return (scopeTotal:searchAlbumResults.albums.total, items:albumsViewModelArr)
    }
    
    func getArtists(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[ArtistOverviewCellViewModel]) {
        let searchArtistEndpoint = SearchArtistEndpoint(searchString: query, limit: limit, offset: offset)
        let searchArtistRequest = APIRequest(endpoint: searchArtistEndpoint, authManager: authManager)
        guard let searchArtistResults = try await searchArtistRequest.executeRequest() else { return (scopeTotal:0, items:[])}
        let artists = searchArtistResults.artists.items
        let artistsViewModelArr = artists.map{ ArtistOverviewCellViewModel(artistsObject:$0) }
        return (scopeTotal:searchArtistResults.artists.total, items:artistsViewModelArr)
    }
    
    func getPlaylists(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[PlaylistOverviewCellViewModel]) {
        let searchPlaylistEndpoint = SearchPlaylistEndpoint(searchString: query, limit: limit, offset: offset)
        let searchPlaylistRequest = APIRequest(endpoint: searchPlaylistEndpoint, authManager: authManager)
        guard let searchPlaylistResults = try await searchPlaylistRequest.executeRequest() else { return (scopeTotal:0, items:[])}
        let playlists = searchPlaylistResults.playlists.items
        let playlistsViewModelArr = playlists.map{ PlaylistOverviewCellViewModel(playlistObject: $0) }
        return (scopeTotal:searchPlaylistResults.playlists.total, items:playlistsViewModelArr)
    }
    
    func getTracks(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[TrackOverviewCellViewModel]) {
        let searchTrackEndpoint = SearchTrackEndpoint(searchString: query, limit: limit, offset: offset)
        let searchTrackRequest = APIRequest(endpoint: searchTrackEndpoint, authManager: authManager)
        guard let searchTrackResults = try await searchTrackRequest.executeRequest() else { return (scopeTotal:0, items:[])}
        let tracks = searchTrackResults.tracks.items
        let tracksViewModelArr = tracks.map{ TrackOverviewCellViewModel(tracksObject: $0) }
        return (scopeTotal:searchTrackResults.tracks.total, items:tracksViewModelArr)
    }
}
