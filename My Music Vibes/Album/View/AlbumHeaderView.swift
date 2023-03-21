//
//  AlbumHeaderView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/17/23.
//

import SwiftUI

struct AlbumHeaderView: View {
    let albumOverviewCellModel:AlbumOverviewCellViewModel
    var body: some View {
        VStack {
            Text(albumOverviewCellModel.primaryText)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Text(albumOverviewCellModel.additionalDetailText)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
            CellImageView(urlString: albumOverviewCellModel.imageUrl)
                .padding(10)
            Text("Genres:" + albumOverviewCellModel.secondaryText)
                .font(.subheadline)
            Text("Popularity: " + albumOverviewCellModel.popularity)
                .font(.caption)
        }
        .padding(20)
    }
}

//struct AlbumHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumHeaderView()
//    }
//}
