//
//  TrackDetailView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/29/23.
//

import SwiftUI



struct TrackDetailView: View {
    let vm: TrackDetailsCollectionViewModel
    private let twoColumnGrid = [GridItem(.flexible(minimum: 160)), GridItem(.flexible(minimum: 160))]
    
    
    var body: some View {
        List {
            Section() {
                TrackHeaderView(trackOverviewCellModel: vm.track)
                    .listRowBackground(ShadowCellView())
                    .listRowSeparator(.hidden)
            }
            ForEach(vm.trackSectionViewModel) { section in
                Section() {
                    LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                        ForEach(section.attributes) { attribute in
                            TrackDetailAttributeView(trackAttribute: attribute)
                        }
                    }
                    .listRowBackground(EmptyView())
                    .listRowSeparator(.hidden)
                } header: {
                    Text(section.title)
                }
            }
        }
        .navigationTitle("Track")
    }
}

//struct TrackDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackDetailView()
//    }
//}
