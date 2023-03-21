//
//  HomeView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    let vm:HomeViewModel
    
    var body: some View {
        List() {
            Section() {
                ForEach(vm.artistRange, id: \.self) { row in
                    let cellViewModel = vm.getArtistCellViewModel(at: row)
                    NavigationLink(value: cellViewModel) {
                        HomeArtistCellView(artistCellViewModel: cellViewModel)
                    }
                }
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            } header: {
                Text("Artists")
            }
            Section() {
                ForEach(vm.trackRange, id: \.self) { row in
                    let cellViewModel = vm.getTrackCellViewModel(at: row)
                    NavigationLink(value: cellViewModel) {
                        HomeTrackCellView(trackCellViewModel: cellViewModel)
                    }
                }
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            } header: {
                Text("Tracks")
            }
            Section() {
                ForEach(vm.playlistRange, id: \.self) { row in
                    let cellViewModel = vm.getPlaylistCellViewModel(at: row)
                    NavigationLink(value: cellViewModel) {
                        HomePlaylistCellView(playlistCellViewModel: cellViewModel)
                    }
                }
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            } header: {
                Text("Playlists")
            }
            
        }
        .navigationTitle("Home")
        .navigationDestination(for: ArtistOverviewCellViewModel.self, destination: { artistCellViewModel in
            ArtistView(vm: ArtistAlbumsViewModel(artist: artistCellViewModel))
        })
        .navigationDestination(for: TrackOverviewCellViewModel.self, destination: { trackCellViewModel in
            TrackView()
        })
        .navigationDestination(for: PlaylistOverviewCellViewModel.self, destination: { playlistCellViewModel in
            PlaylistView()
        })
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
