//
//  AlbumView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/17/23.
//

import SwiftUI

struct AlbumView: View {
    let vm: AlbumTracksViewModel
    
    var body: some View {
        List() {
            Section() {
                AlbumHeaderView(albumOverviewCellModel: vm.album)
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            }
            Section() {
                ForEach(vm.trackRange, id: \.self) { row in
                    let cellViewModel = vm.getTrackAndDetailsVM(at: row)
                    NavigationLink(value: cellViewModel) {
                        AlbumTracksCellView(trackDetailCellViewModel: cellViewModel)
                    }
                }
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            } header: {
                Text("Tracks")
            }
        }
        .navigationTitle("Album")
//        .navigationDestination(for: AlbumOverviewCellViewModel.self, destination: { albumOverviewCellViewModel in
//            AlbumView(vm: AlbumTracksViewModel(album: albumOverviewCellViewModel))
//        })
    }
}

//struct AlbumView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumView()
//    }
//}
