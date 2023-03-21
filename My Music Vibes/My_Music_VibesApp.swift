//
//  My_Music_VibesApp.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import SwiftUI

@main
struct My_Music_VibesApp: App {
    
    var body: some Scene {
        WindowGroup {
            let service = KeychainHelper.tokenSeviceStr
            if KeychainHelper.standard.read(service: service, type: TokenStorageObject.self) != nil {
                CoreTabBarView()
            } else {
                WelcomeView()
            }
        }
    }
}

//        KeychainHelper.standard.delete(service: service)
//        KeychainHelper.standard.delete(service: KeychainHelper.refreshSeviceStr)
