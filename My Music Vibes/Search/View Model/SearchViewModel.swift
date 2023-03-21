//
//  SearchViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

final class SearchViewModel {
    private (set) var isSearching:Bool = false
    
    private (set) var currentSearchScope:SearchType = .all
    private (set) var currentScopeTotal:Int = 0
    
    private var currentScopeCountOffset:Int {
        if self.currentSearchScope == .all {
            return 0
        }
        return self.searchViewModelCells.count
    }
    
    private var currentQuery:String = ""
    private let searchFetcher:SearchFetcher
    
    private (set) var searchViewModelCells:[ItemOverviewCellViewModelProtocol] = []
    
    init(searchFetcher:SearchFetcher = SearchFetcher()) {
        self.searchFetcher = searchFetcher
    }
    
    
    func searchMusic(type:String, query:String) async throws {
        defer { self.isSearching = false }
        
        guard !isSearching else { return }
        guard let filter = SearchType(rawValue: type) else { return }
        self.currentSearchScope = filter
        self.currentQuery = query
        self.isSearching = true
        switch filter {
        case .all:
            self.searchViewModelCells = try await self.searchFetcher.getAll(query: query)
        case .album:
            let albumData = try await self.searchFetcher.getAlbum(query: query, limit: 20, offset: 0)
            self.searchViewModelCells = albumData.items
            self.currentScopeTotal = albumData.scopeTotal
        case .artist:
            let artistData = try await self.searchFetcher.getArtists(query: query, limit: 20, offset: 0)
            self.searchViewModelCells = artistData.items
            self.currentScopeTotal = artistData.scopeTotal
        case .playlist:
            let playlistData = try await self.searchFetcher.getPlaylists(query: query, limit: 20, offset: 0)
            self.searchViewModelCells = playlistData.items
            self.currentScopeTotal = playlistData.scopeTotal
        case .track:
            let trackData = try await self.searchFetcher.getTracks(query: query, limit: 20, offset: 0)
            self.searchViewModelCells = trackData.items
            self.currentScopeTotal = trackData.scopeTotal
        }
    }
    
    func searchMoreMusic() async throws {
        defer { self.isSearching = false }
        
        guard !isSearching else { return }
        self.isSearching = true
        switch self.currentSearchScope {
        case .all:
            break
        case .album:
            let additionalAlbumsData = try await self.searchFetcher.getAlbum(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalAlbumsData.items)
          //  self.currentScopeTotal = additionalAlbumsData.scopeTotal
        case .artist:
            let additionalArtistsData = try await self.searchFetcher.getArtists(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalArtistsData.items)
          //  self.currentScopeTotal = additionalArtistsData.scopeTotal
        case .playlist:
            let additionalPlaylistsData = try await self.searchFetcher.getPlaylists(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalPlaylistsData.items)
          //  self.currentScopeTotal = additionalPlaylistsData.scopeTotal
        case .track:
            let additionalTracksData = try await self.searchFetcher.getTracks(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalTracksData.items)
          //  self.currentScopeTotal = additionalTracksData.scopeTotal
     
        }
        //self.isSearching = false
    }
    
    

}
