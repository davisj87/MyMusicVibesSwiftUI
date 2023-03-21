//
//  ArtistView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/10/23.
//

import SwiftUI

struct ArtistView: View {
    let vm: ArtistAlbumsViewModel
    
    var body: some View {
        List() {
            Section() {
                ArtistHeaderView(artistOverviewCellModel: vm.artist)
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            }
            Section() {
                ForEach(vm.albumRange, id: \.self) { row in
                    let cellViewModel = vm.getAlbumVM(at: row)
                    NavigationLink(value: cellViewModel) {
                        ArtistAlbumsCellView(albumOverviewCellViewModel: cellViewModel)
                    }
                }
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            } header: {
                Text("Albums")
            }
        }
        .navigationTitle("Artist")
        .navigationDestination(for: AlbumOverviewCellViewModel.self, destination: { albumOverviewCellViewModel in
            AlbumView(vm: AlbumTracksViewModel(album: albumOverviewCellViewModel))
        })
    }
}



//struct ArtistView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistView()
//    }
//}
