//
//  ArtistView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/10/23.
//

import SwiftUI

struct ArtistView: View {
    @StateObject var vm: ArtistAlbumsViewModel
    @State private var didAppear = false
    
    var body: some View {
        List() {
            Section() {
                ArtistHeaderView(artistOverviewCellModel: vm.artist)
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            }
            Section() {
                ForEach(vm.albumOverviewCellViewModels, id: \.id) { row in
                    NavigationLink(value: row) {
                        ArtistAlbumsCellView(albumOverviewCellViewModel: row)
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
        .onAppear(perform:firstLoad)
    }
    
    
    func firstLoad() {
        if !didAppear {
            didAppear = true
            Task {
                try await self.vm.getAlbumData()
            }
        }
    }
}



//struct ArtistView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistView()
//    }
//}
