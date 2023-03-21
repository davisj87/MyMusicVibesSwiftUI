//
//  HomeTrackCellView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/10/23.
//

import SwiftUI

struct HomeTrackCellView: View {
    let trackCellViewModel:TrackOverviewCellViewModel
    
    var body: some View {
        HStack {
            CellImageView(urlString: trackCellViewModel.imageUrl)
            VStack {
                Text(trackCellViewModel.primaryText)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(trackCellViewModel.secondaryText)
                    .font(.subheadline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
            Text("Pop:\n\(trackCellViewModel.popularity)")
                .font(.footnote)
        }
        .padding(10)
    }
}

//struct HomeTrackCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTrackCellView()
//    }
//}
