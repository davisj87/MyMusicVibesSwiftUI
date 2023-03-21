//
//  ViewModelState.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/21/23.
//

import Foundation

enum ViewModelState {
    case loading
    case loaded
    case empty(String)
    case error(String)
}
