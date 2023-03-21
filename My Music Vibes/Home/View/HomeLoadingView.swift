//
//  HomeLoadingView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/20/23.
//

import SwiftUI

struct HomeLoadingView: View {
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    @State private var didAppear = false
    
    var body: some View {
        NavigationStack {
            switch vm.state {
            case let .loaded(tracks: tracks, artists: artists, playlists: playlists):
                HomeView(tracks: tracks, artists: artists, playlists: playlists)
            case let .empty(message):
                ErrorView(message: message, color: .gray)
            case let .error( message):
                ErrorView(message: message, color: .red)
            case .loading:
                ProgressView()
                    .onAppear(perform:firstLoad)
            }
        }
    }
    
    func firstLoad() {
        if !didAppear {
            didAppear = true
            Task {
                try await self.vm.loadTopItems()
            }
        }
    }
}


//struct HomeLoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeLoadingView()
//    }
//}
