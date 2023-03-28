//
//  PlaylistView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/10/23.
//

import SwiftUI

struct PlaylistView: View {
    let vm: PlaylistTracksViewModel
    
    var body: some View {
        List() {
            Section() {
                PlaylistHeaderView(playlistOverviewCellModel: vm.playlist)
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
        .navigationTitle("Playlist")
    }
}

//struct PlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistView()
//    }
//}
