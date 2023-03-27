//
//  ArtistHeaderView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/17/23.
//

import SwiftUI

struct ArtistHeaderView: View {
    let artistOverviewCellModel:any ItemOverviewCellViewModelProtocol
    var body: some View {
        VStack {
            Text(artistOverviewCellModel.primaryText)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Text(artistOverviewCellModel.additionalDetailText)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
            CellImageView(urlString: artistOverviewCellModel.imageUrl)
                .padding(10)
            Text("Genres:" + artistOverviewCellModel.secondaryText)
                .font(.subheadline)
            Text("Popularity: " + artistOverviewCellModel.popularity)
                .font(.caption)
        }
        .padding(20)
    }
}

//struct ArtistHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistHeaderView()
//    }
//}
