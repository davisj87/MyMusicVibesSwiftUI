//
//  HomePlaylistView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/10/23.
//

import SwiftUI

struct HomePlaylistCellView: View {
    let playlistCellViewModel:PlaylistOverviewCellViewModel
    
    var body: some View {
        HStack {
            CellImageView(urlString: playlistCellViewModel.imageUrl)
            VStack {
                Text(playlistCellViewModel.primaryText)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(playlistCellViewModel.secondaryText)
                    .font(.subheadline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
        }
        .padding(10)
    }
}
//
//struct HomePlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePlaylistView()
//    }
//}
