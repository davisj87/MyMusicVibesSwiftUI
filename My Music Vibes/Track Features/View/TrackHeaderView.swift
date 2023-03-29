//
//  TrackHeaderView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/29/23.
//

import SwiftUI

struct TrackHeaderView: View {
    let trackOverviewCellModel:any ItemOverviewCellViewModelProtocol
    var body: some View {
        VStack {
            Text(trackOverviewCellModel.primaryText)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Text(trackOverviewCellModel.additionalDetailText)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
            CellImageView(urlString: trackOverviewCellModel.imageUrl)
                .padding(10)
            Text("Genres:" + trackOverviewCellModel.secondaryText)
                .font(.subheadline)
            Text("Popularity: " + trackOverviewCellModel.popularity)
                .font(.caption)
        }
        .padding(20)
    }
}

//struct TrackHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackHeaderView()
//    }
//}
