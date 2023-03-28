//
//  PlaylistLoadingView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/28/23.
//

import SwiftUI

struct PlaylistLoadingView: View {
    @StateObject var vm: PlaylistTracksViewModel
    @State private var didAppear = false
    
    var body: some View {
        switch vm.state {
        case .loaded:
            PlaylistView(vm:vm)
        case let .empty(message):
            ErrorView(message: message, color: .gray)
        case let .error( message):
            ErrorView(message: message, color: .red)
        case .loading:
            ProgressView()
                .onAppear(perform:firstLoad)
        }
    }
    
    func firstLoad() {
        if !didAppear {
            didAppear = true
            Task {
                try await self.vm.getTracks()
            }
        }
    }
}

//struct PlaylistLoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistLoadingView()
//    }
//}
