//
//  ContentView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import SwiftUI

struct StandardLabel: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .frame(width: 200, height: 40)
            .background(color)
            .cornerRadius(15)
            .padding()
    }
}

struct WelcomeView: View {
    @State private var showingAuth = false
    @State private var isAuthorized = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    self.showingAuth.toggle()
                }, label: {
                    StandardLabel(text: "Continue", color: Color.green)
                    })
                .sheet(isPresented: $showingAuth, onDismiss: didDismiss) {
                    AuthView()
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .padding()
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $isAuthorized) {
                HomeLoadingView()
            }
        }
        
    }
    
    func didDismiss() {
        //check if we have valid token and if so set flag to true
        self.isAuthorized = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
