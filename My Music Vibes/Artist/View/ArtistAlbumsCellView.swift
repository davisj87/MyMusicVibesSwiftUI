//
//  ArtistAlbumsCellView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/17/23.
//

import SwiftUI


struct ArtistAlbumsCellView: View {
    let albumOverviewCellViewModel:AlbumOverviewCellViewModel
    
    var body: some View {
        HStack {
            CellImageView(urlString: albumOverviewCellViewModel.imageUrl)
            VStack {
                Text(albumOverviewCellViewModel.primaryText)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(albumOverviewCellViewModel.secondaryText)
                    .font(.subheadline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
        }
        .padding(10)
    }
}

//struct ArtistAlbumsCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistAlbumsCellView()
//    }
//}
