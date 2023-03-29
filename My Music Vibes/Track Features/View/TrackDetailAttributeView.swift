//
//  TrackDetailAttributeView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/29/23.
//

import SwiftUI

struct TrackDetailAttributeView: View {
    var trackAttribute:TrackCollectionViewCellViewModel
    
    var body: some View {
        ZStack {
            ShadowCellView()
            VStack {
                Text(trackAttribute.name)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                Text(trackAttribute.value)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(20)
            .padding(.vertical, 20)
        }
        
    }
}

struct TrackDetailAttributeView_Previews: PreviewProvider {
    static var previews: some View {
        let trackAttr = TrackCollectionViewCellViewModel(name: "Test", value: "Test Value")
        TrackDetailAttributeView(trackAttribute: trackAttr)
    }
}
