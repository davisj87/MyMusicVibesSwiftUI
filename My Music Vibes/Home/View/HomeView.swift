//
//  HomeView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    let tracks: [TrackOverviewCellViewModel]
    let artists: [ArtistOverviewCellViewModel]
    let playlists: [PlaylistOverviewCellViewModel]
    
    var body: some View {
        List() {
            Section() {
                ForEach(artists, id: \.id) { row in
                    NavigationLink(value: row) {
                        HomeArtistCellView(artistCellViewModel: row)
                    }
                }
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            } header: {
                Text("Artists")
            }
            Section() {
                ForEach(tracks, id: \.id) { row in
                    NavigationLink(value: row) {
                        HomeTrackCellView(trackCellViewModel: row)
                    }
                }
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            } header: {
                Text("Tracks")
            }
            Section() {
                ForEach(playlists, id: \.id) { row in
                    NavigationLink(value: row) {
                        HomePlaylistCellView(playlistCellViewModel: row)
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
