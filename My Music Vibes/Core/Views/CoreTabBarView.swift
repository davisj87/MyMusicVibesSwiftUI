//
//  CoreTabBarView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/15/23.
//

import SwiftUI

struct CoreTabBarView: View {
    var body: some View {
        TabView {
            HomeLoadingView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchLoadingView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct CoreTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CoreTabBarView()
    }
}
