//
//  TracksChartDetailViewFormatter.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import SwiftUI

protocol TracksChartDetailViewFormatter {}

extension TracksChartDetailViewFormatter {
    
    func getColorArrForEnergy(minValue:Float, maxValue:Float) -> [Color] {
        var minIndex = 0
        var maxIndex = 4
        let colorArr:[Color] = [.gray, .purple, .blue, .teal, .green]
        var finalColorArr:[Color] = []
        
        switch Int(minValue) {
        case 0...20:
            minIndex = 0
        case 21...45:
            minIndex = 1
        case 46...55:
            minIndex = 2
        case 56...79:
            minIndex = 3
        case 80...100:
            minIndex = 4
        default:
            minIndex = 0
        }
        
        switch Int(maxValue) {
        case 0...20:
            maxIndex = 0
        case 21...45:
            maxIndex = 1
        case 46...55:
            maxIndex = 2
        case 56...79:
            maxIndex = 3
        case 80...100:
            maxIndex = 4
        default:
            maxIndex = 0
        }
        
        for i in (minIndex...maxIndex).reversed() {
            finalColorArr.append(colorArr[i])
        }
        return finalColorArr
    }
}

