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
               // let cellViewModel = vm.getArtistCellViewModel(at: row)
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
            case .all:
                Text("all")
            case .playlist:
                Text("playlist")
            case .artist:
                ArtistLoadingView(vm: ArtistAlbumsViewModel(artist: overviewCellViewModel))
            case .album:
                Text("album")
            case .track:
                Text("track")
            }
           // ArtistLoadingView(vm: ArtistAlbumsViewModel(artist: artistCellViewModel))
        })
            
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
