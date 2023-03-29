//
//  TrackDetailLoadingView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/29/23.
//

import SwiftUI

struct TrackDetailLoadingView: View {
    @StateObject var vm: TrackDetailsCollectionViewModel
    @State private var didAppear = false
    
    var body: some View {
        switch vm.state {
        case .loaded:
            TrackDetailView(vm:vm)
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
                try await self.vm.getTrack()
            }
        }
    }
}

//struct TrackDetailLoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackDetailLoadingView()
//    }
//}
