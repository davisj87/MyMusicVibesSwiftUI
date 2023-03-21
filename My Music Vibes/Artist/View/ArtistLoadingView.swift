//
//  ArtistLoadingView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/21/23.
//

import SwiftUI

struct ArtistLoadingView: View {
    @StateObject var vm: ArtistAlbumsViewModel
    @State private var didAppear = false
    
    var body: some View {
        switch vm.state {
        case .loaded:
            ArtistView(vm:vm)
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
                try await self.vm.getAlbumData()
            }
        }
    }
}

//struct ArtistLoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistLoadingView()
//    }
//}
