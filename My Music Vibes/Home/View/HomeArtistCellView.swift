//
//  HomeCellView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/10/23.
//

import SwiftUI

struct HomeArtistCellView: View {
    let artistCellViewModel:ArtistOverviewCellViewModel
    
    var body: some View {
        HStack {
            CellImageView(urlString: artistCellViewModel.imageUrl)
            VStack {
                Text(artistCellViewModel.primaryText)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(artistCellViewModel.secondaryText)
                    .font(.subheadline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
            Text("Pop:\n\(artistCellViewModel.popularity)")
                .font(.footnote)
        }
        .padding(10)
    }
}

//struct HomeCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeCellView()
//    }
//}
