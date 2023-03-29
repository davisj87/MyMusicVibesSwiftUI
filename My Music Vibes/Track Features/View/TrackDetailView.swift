//
//  TrackDetailView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/29/23.
//

import SwiftUI



struct TrackDetailView: View {
    let vm: TrackDetailsCollectionViewModel
    private let layout = [GridItem(.adaptive(minimum: 150), spacing: 2)]
    
    
    var body: some View {
        List {
            Section() {
                TrackHeaderView(trackOverviewCellModel: vm.track)
                    .listRowBackground(ShadowCellView())
                    .listRowSeparator(.hidden)
            }
            ForEach(vm.trackSectionViewModel) { section in
                Section() {
                    LazyVGrid(columns: layout, spacing: 10) {
                        ForEach(section.attributes) { attribute in
                            TrackDetailAttributeView(trackAttribute: attribute)
                            .padding()
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
