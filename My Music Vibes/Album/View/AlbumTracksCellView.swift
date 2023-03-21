//
//  AlbumTracksCellView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/17/23.
//

import SwiftUI

struct AlbumTracksCellView: View {
    let trackDetailCellViewModel:TrackDetailTableViewCellViewModel
    
    var body: some View {
        HStack {
            CellImageView(urlString: trackDetailCellViewModel.imageUrl)
            VStack {
                Text(trackDetailCellViewModel.name)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(trackDetailCellViewModel.artist)
                    .font(.subheadline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
        }
        .padding(10)
    }
}

//struct AlbumTracksCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumTracksCellView()
//    }
//}
