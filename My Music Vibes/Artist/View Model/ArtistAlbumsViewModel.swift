//
//  ArtistAlbumsViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

@MainActor final class ArtistAlbumsViewModel: ObservableObject  {
    private var isPaginating:Bool = false
   // private var albums:[AlbumObject] = []
    private (set) var albumTotal:Int = 0
    
    @Published private (set) var albumOverviewCellViewModels:[AlbumOverviewCellViewModel] = []
//
//    var albumCount:Int {
//        return albums.count
//    }
    
//    func getAlbumVM(at index:Int) -> AlbumOverviewCellViewModel {
//        let album = albums[index]
//        return AlbumCellViewModel(albumObject: album)
//    }
    
    let artist:ArtistOverviewCellViewModel
    private let artistAlbumsFetcher:ArtistAlbumsFetcherProtocol
    
    init(artist:ArtistOverviewCellViewModel, artistAlbumsFetcher:ArtistAlbumsFetcherProtocol = ArtistAlbumsFetcher()) {
        self.artist = artist
        self.artistAlbumsFetcher = artistAlbumsFetcher
    }
    
    func getAlbumData() async throws {
        let albumData = try await self.artistAlbumsFetcher.getAlbumsFromArtist(artistId: self.artist.id)
        self.albumTotal = albumData.total
        self.albumOverviewCellViewModels = albumData.items.map{ AlbumOverviewCellViewModel(albumObject: $0) }
       // self.albums = albumData.items
    }
    
    func getMoreAlbumData() async throws {
        defer { self.isPaginating = false }
        guard self.albumTotal > self.albumOverviewCellViewModels.count else { return }
        if !isPaginating {
            self.isPaginating = true
            let moreAlbumData = try await self.artistAlbumsFetcher.getMoreAlbumsFromArtist(artistId: self.artist.id, offset: self.albumOverviewCellViewModels.count)
            guard !moreAlbumData.isEmpty else { return }
            let moreAlbumOverviewCells = moreAlbumData.map{ AlbumOverviewCellViewModel(albumObject: $0) }
            self.albumOverviewCellViewModels.append(contentsOf: moreAlbumOverviewCells)
        }
    }
}
