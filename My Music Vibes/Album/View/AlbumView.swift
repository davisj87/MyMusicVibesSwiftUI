//
//  AlbumView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/17/23.
//

import SwiftUI

struct AlbumView: View {
    @StateObject var vm: AlbumTracksViewModel
    @State private var didAppear = false
    
    var body: some View {
        List() {
            Section() {
                AlbumHeaderView(albumOverviewCellModel: vm.album)
                .listRowBackground(ShadowCellView())
                .listRowSeparator(.hidden)
            }
            Section() {
                ForEach(vm.trackDetailsCellViewModels, id: \.id) { row in
                    NavigationLink(value: row) {
                        AlbumTracksCellView(trackDetailCellViewModel: row)
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
        .onAppear(perform:firstLoad)
    }
    func firstLoad() {
        if !didAppear {
            didAppear = true
            Task {
                try await self.vm.getTracksData()
            }
        }
    }
}

//struct AlbumView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumView()
//    }
//}
