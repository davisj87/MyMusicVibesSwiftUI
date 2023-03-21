//
//  ErrorView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/20/23.
//

import SwiftUI

struct ErrorView:View {
    let message:String
    let color:Color
    @State private var showingAlert = false
    var body: some View {
        Button("Oops, sorry about that") {
            showingAlert = true
        }
        .alert(message, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Sorry about that", color: .red)
    }
}
