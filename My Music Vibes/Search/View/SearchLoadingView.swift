//
//  SearchLoadingView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/27/23.
//

import SwiftUI

struct SearchLoadingView: View {
    @StateObject private var vm: SearchViewModel = SearchViewModel()
    @State private var didAppear = false
    @State private var searchText = ""
    @State private var searchScope = SearchType.all
    
    var body: some View {
        NavigationStack {
            switch vm.state {
            case .loaded:
                SearchView(vm:vm)
            case let .empty(message):
                ErrorView(message: message, color: .gray)
            case let .error( message):
                ErrorView(message: message, color: .red)
            case .loading:
                ProgressView()
            }
        }
        .searchable(text: $searchText, prompt: "Search for Songs, Artists, Albums, or Playlist")
        .searchScopes($searchScope) {
            ForEach(SearchType.allCases, id: \.self) { scope in
                Text(scope.rawValue.capitalized)
            }
        }
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchScope) { _ in
            runSearch()
        }
        
    }
    
    func runSearch() {
        Task {
            try await self.vm.searchMusic(type:searchScope.rawValue, query:searchText)
        }
    }
}

//struct SearchLoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchLoadingView()
//    }
//}
