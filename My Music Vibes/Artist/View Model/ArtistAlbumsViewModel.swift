//
//  ArtistAlbumsViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation


@MainActor final class ArtistAlbumsViewModel: ObservableObject  {
    private var isPaginating:Bool = false
    private var albums:[AlbumObject] = []
    private (set) var albumTotal:Int = 0
    
    @Published var state: ViewModelState = .loading

    var albumRange:Range<Int>  {
        return albums.indices
    }
    
    func getAlbumVM(at index:Int) -> AlbumOverviewCellViewModel {
        return AlbumOverviewCellViewModel(albumObject: albums[index])
    }
    
    let artist:any ItemOverviewCellViewModelProtocol
    private let artistAlbumsFetcher:ArtistAlbumsFetcherProtocol
    
    init(artist:some ItemOverviewCellViewModelProtocol, artistAlbumsFetcher:ArtistAlbumsFetcherProtocol = ArtistAlbumsFetcher()) {
        self.artist = artist
        self.artistAlbumsFetcher = artistAlbumsFetcher
    }
    
    func getAlbumData() async throws {
        self.albums = []
        do {
            let albumData = try await self.artistAlbumsFetcher.getAlbumsFromArtist(artistId: self.artist.id)
            self.albumTotal = albumData.total
            self.albums = albumData.items
            
            if albums.isEmpty {
                state = .empty("This artist has no albums.")
            } else {
                state = .loaded
            }
            
        } catch {
            state = .error("There was an error loading your data")
        }
    }
    
    func getMoreAlbumData() async throws {
        defer { self.isPaginating = false }
        guard self.albumTotal > self.albums.count else { return }
        if !isPaginating {
            self.isPaginating = true
            let moreAlbumData = try await self.artistAlbumsFetcher.getMoreAlbumsFromArtist(artistId: self.artist.id, offset: self.albums.count)
            guard !moreAlbumData.isEmpty else { return }
            self.albums.append(contentsOf: moreAlbumData)
        }
    }
}
