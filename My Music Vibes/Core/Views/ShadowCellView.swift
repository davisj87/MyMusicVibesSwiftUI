//
//  ShadowView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/16/23.
//

import SwiftUI

struct ShadowCellView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : .white)
            .background(.clear)
            .padding(EdgeInsets(top: 10,
                                leading: 10,
                                bottom: 10,
                                trailing: 10))
            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.8): Color.black.opacity(0.23), radius: 8)
    }
}

struct ShadowView_Previews: PreviewProvider {
    static var previews: some View {
        ShadowCellView()
    }
}
