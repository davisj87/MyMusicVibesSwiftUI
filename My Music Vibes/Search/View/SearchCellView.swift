//
//  SearchCellView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/27/23.
//

import SwiftUI

struct SearchCellView: View {
    let cellViewModel:OverviewCellViewModel
    var body: some View {
        HStack {
            CellImageView(urlString: cellViewModel.imageUrl)
            VStack {
                Text(cellViewModel.primaryText)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(cellViewModel.secondaryText)
                    .font(.subheadline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
        }
        .padding(10)
    }
}

//struct SearchCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchCellView()
//    }
//}
