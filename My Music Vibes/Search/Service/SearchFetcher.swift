//
//  SearchFetcher.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

protocol SearchFetcherProtocol {
    func getAll(query:String) async throws -> [OverviewCellViewModel]
    func getAlbum(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[OverviewCellViewModel])
    func getArtists(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[OverviewCellViewModel])
    func getPlaylists(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[OverviewCellViewModel])
    func getTracks(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[OverviewCellViewModel])
}

struct SearchFetcher:SearchFetcherProtocol {
    private let authManager = AuthManager()
    
    func getAll(query:String) async throws -> [OverviewCellViewModel] {
        let searchAllEndpoint = SearchAllEndpoint(searchString: query)
        let searchAllRequest = APIRequest(endpoint: searchAllEndpoint, authManager: authManager)
        guard let searchAllResults = try await searchAllRequest.executeRequest() else { return []}
        
        let albums = searchAllResults.albums.items
        let albumCellVM = albums.map{ album in
            let searchAlbumViewModel = SearchAllCellViewModel(albumObject: album)
            return OverviewCellViewModel(model: searchAlbumViewModel)
        }
        
        let playlists = searchAllResults.playlists.items
        let playlistCellVM = playlists.map{ playlist in
            let searchPlaylistViewModel = SearchAllCellViewModel(playlistObject: playlist)
            return OverviewCellViewModel(model: searchPlaylistViewModel)
        }
        
        let tracks = searchAllResults.tracks.items
        let tracksCellVM = tracks.map{ track in
            let searchTrackViewModel = SearchAllCellViewModel(tracksObject: track)
            return OverviewCellViewModel(model: searchTrackViewModel)
        }
        
        let artists = searchAllResults.artists.items
        let artistCellVM = artists.map{ artist in
            let searchArtistViewModel = SearchAllCellViewModel(artistsObject:artist)
            return OverviewCellViewModel(model: searchArtistViewModel)
        }
        
        return albumCellVM + playlistCellVM + tracksCellVM + artistCellVM
    }
    
    func getAlbum(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[OverviewCellViewModel]) {
        let searchAlbumEndpoint = SearchAlbumEndpoint(searchString: query, limit: limit, offset: offset)
        let searchAlbumRequest = APIRequest(endpoint: searchAlbumEndpoint, authManager: authManager)
        guard let searchAlbumResults = try await searchAlbumRequest.executeRequest() else { return (scopeTotal:0, items:[])}
        let albums = searchAlbumResults.albums.items
        let albumsViewModelArr = albums.map{ album in
            let searchAlbumViewModel = AlbumOverviewCellViewModel(albumObject: album)
            return OverviewCellViewModel(model: searchAlbumViewModel)
        }
        return (scopeTotal:searchAlbumResults.albums.total, items:albumsViewModelArr)
    }
    
    func getArtists(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[OverviewCellViewModel]) {
        let searchArtistEndpoint = SearchArtistEndpoint(searchString: query, limit: limit, offset: offset)
        let searchArtistRequest = APIRequest(endpoint: searchArtistEndpoint, authManager: authManager)
        guard let searchArtistResults = try await searchArtistRequest.executeRequest() else { return (scopeTotal:0, items:[])}
        let artists = searchArtistResults.artists.items
        let artistsViewModelArr = artists.map{ artist in
            let searchArtistViewModel = ArtistOverviewCellViewModel(artistsObject:artist)
            return OverviewCellViewModel(model: searchArtistViewModel)
        }
        return (scopeTotal:searchArtistResults.artists.total, items:artistsViewModelArr)
    }
    
    func getPlaylists(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[OverviewCellViewModel]) {
        let searchPlaylistEndpoint = SearchPlaylistEndpoint(searchString: query, limit: limit, offset: offset)
        let searchPlaylistRequest = APIRequest(endpoint: searchPlaylistEndpoint, authManager: authManager)
        guard let searchPlaylistResults = try await searchPlaylistRequest.executeRequest() else { return (scopeTotal:0, items:[])}
        let playlists = searchPlaylistResults.playlists.items
        let playlistsViewModelArr = playlists.map{ playlist in
            let searchPlaylistViewModel = PlaylistOverviewCellViewModel(playlistObject: playlist)
            return OverviewCellViewModel(model: searchPlaylistViewModel)
        }
        return (scopeTotal:searchPlaylistResults.playlists.total, items:playlistsViewModelArr)
    }
    
    func getTracks(query:String, limit:Int, offset:Int) async throws -> (scopeTotal:Int, items:[OverviewCellViewModel]) {
        let searchTrackEndpoint = SearchTrackEndpoint(searchString: query, limit: limit, offset: offset)
        let searchTrackRequest = APIRequest(endpoint: searchTrackEndpoint, authManager: authManager)
        guard let searchTrackResults = try await searchTrackRequest.executeRequest() else { return (scopeTotal:0, items:[])}
        let tracks = searchTrackResults.tracks.items
        let tracksViewModelArr = tracks.map{ track in
            let searchTrackViewModel = TrackOverviewCellViewModel(tracksObject: track)
            return OverviewCellViewModel(model: searchTrackViewModel)
        }
        return (scopeTotal:searchTrackResults.tracks.total, items:tracksViewModelArr)
    }
}
