//
//  HomeCellImageView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/10/23.
//

import SwiftUI

struct CellImageView: View {
    let urlString:String
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                Color.purple.opacity(0.1)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
        }
        .frame(width: 50, height: 50)
        .cornerRadius(10)
    }
}


struct HomeCellImageView_Previews: PreviewProvider {
    static var previews: some View {
        CellImageView(urlString: "https://i.scdn.co/image/ab67616d0000b2737a86bb15e9c4eeb5fb4f5f4c")
    }
}
