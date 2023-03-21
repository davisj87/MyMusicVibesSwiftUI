//
//  AuthView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var vm = AuthViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                AuthWebView(vm: vm)
                if vm.webViewState == .success {
                    VStack{
                        Text("Successful account connection!\n Click below to continue")
                            .multilineTextAlignment(.center)
                            .padding(20)
                        Button(action: {
                            dismiss()
                        }, label: {
                            StandardLabel(text: "Continue", color: Color.green)
                        })
                    }
                }
            }
            .navigationTitle("Sign In")
        }
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
