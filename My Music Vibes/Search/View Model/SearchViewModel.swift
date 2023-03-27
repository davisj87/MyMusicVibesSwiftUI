//
//  SearchViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

@MainActor final class SearchViewModel: ObservableObject {
    @Published var state: ViewModelState = .empty("Type in the search bar to get started")
    
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
    private let searchFetcher:SearchFetcherProtocol
    
    private (set) var searchViewModelCells:[OverviewCellViewModel] = []
    
    init(searchFetcher:some SearchFetcherProtocol = SearchFetcher()) {
        self.searchFetcher = searchFetcher
    }
    
    
    func searchMusic(type:String, query:String) async throws {
        defer { self.isSearching = false }
        
        guard !isSearching else { return }
        self.searchViewModelCells = []
        guard let filter = SearchType(rawValue: type) else { return }
        self.currentSearchScope = filter
        self.currentQuery = query
        self.isSearching = true
        state = .loading
        
        switch filter {
        case .all:
            do {
                self.searchViewModelCells = try await self.searchFetcher.getAll(query: query)
                state = self.searchViewModelCells.isEmpty ? .empty("No Items Found") : .loaded
            } catch {
                state = .error("There was an error loading your data")
            }
        case .album:
            do {
                let albumData = try await self.searchFetcher.getAlbum(query: query, limit: 20, offset: 0)
                self.searchViewModelCells = albumData.items
                self.currentScopeTotal = albumData.scopeTotal
                state = self.searchViewModelCells.isEmpty ? .empty("No Albums Found") : .loaded
            } catch {
                state = .error("There was an error loading your data")
            }
        case .artist:
            do {
                let artistData = try await self.searchFetcher.getArtists(query: query, limit: 20, offset: 0)
                self.searchViewModelCells = artistData.items
                self.currentScopeTotal = artistData.scopeTotal
                state = self.searchViewModelCells.isEmpty ? .empty("No Artists Found") : .loaded
            } catch {
                state = .error("There was an error loading your data")
            }
            
        case .playlist:
            do {
                let playlistData = try await self.searchFetcher.getPlaylists(query: query, limit: 20, offset: 0)
                self.searchViewModelCells = playlistData.items
                self.currentScopeTotal = playlistData.scopeTotal
                state = self.searchViewModelCells.isEmpty ? .empty("No Playlists Found") : .loaded
            } catch {
                state = .error("There was an error loading your data")
            }
        case .track:
            do {
                let trackData = try await self.searchFetcher.getTracks(query: query, limit: 20, offset: 0)
                self.searchViewModelCells = trackData.items
                self.currentScopeTotal = trackData.scopeTotal
                state = self.searchViewModelCells.isEmpty ? .empty("No Tracks Found") : .loaded
            } catch {
                state = .error("There was an error loading your data")
            }

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
        case .artist:
            let additionalArtistsData = try await self.searchFetcher.getArtists(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalArtistsData.items)
        case .playlist:
            let additionalPlaylistsData = try await self.searchFetcher.getPlaylists(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalPlaylistsData.items)
        case .track:
            let additionalTracksData = try await self.searchFetcher.getTracks(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalTracksData.items)
     
        }
    }
    
    

}
