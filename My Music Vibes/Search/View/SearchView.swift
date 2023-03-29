//
//  SearchView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/15/23.
//

import SwiftUI

struct SearchView: View {
    let vm: SearchViewModel
    var body: some View {
        List() {
            ForEach(vm.searchViewModelCells, id: \.self) { row in
                NavigationLink(value: row) {
                    SearchCellView(cellViewModel: row)
                }
            }
            .listRowBackground(ShadowCellView())
            .listRowSeparator(.hidden)
        }
        .navigationTitle("Search")
        .navigationDestination(for: OverviewCellViewModel.self, destination: { overviewCellViewModel in
            switch overviewCellViewModel.searchType {
            case .playlist:
                PlaylistLoadingView(vm: PlaylistTracksViewModel(playlist: overviewCellViewModel))
            case .artist:
                ArtistLoadingView(vm: ArtistAlbumsViewModel(artist: overviewCellViewModel))
            case .album:
                AlbumLoadingView(vm: AlbumTracksViewModel(album: overviewCellViewModel))
            case .track:
                TrackDetailLoadingView(vm: TrackDetailsCollectionViewModel(track: overviewCellViewModel))
            default:
                Text("Error")
            }
        })
            
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
