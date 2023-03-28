//
//  PlaylistHeaderView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/28/23.
//

import SwiftUI

struct PlaylistHeaderView: View {
    let playlistOverviewCellModel: any ItemOverviewCellViewModelProtocol
    var body: some View {
        VStack {
            Text(playlistOverviewCellModel.primaryText)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Text(playlistOverviewCellModel.additionalDetailText)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
            CellImageView(urlString: playlistOverviewCellModel.imageUrl)
                .padding(10)
            Text("Genres:" + playlistOverviewCellModel.secondaryText)
                .font(.subheadline)
            Text("Popularity: " + playlistOverviewCellModel.popularity)
                .font(.caption)
        }
        .padding(20)
    }
}

//struct PlaylistHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistHeaderView()
//    }
//}
