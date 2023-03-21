//
//  AlbumTracksChartViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import SwiftUI

final class AlbumTracksChartViewModel: ObservableObject, TrackDetailViewFormatter, TracksChartDetailViewFormatter {
    
    private var albumTracks:[TracksObject]
    private var trackDetails:Set<TrackFeaturesObject?>
    
    @Published var musicalPositivityArr:[MusicalPositivity] = []
    @Published var energyArr:(energyData:[EnergyChartViewModel], energyColorArr:[Color]) = (energyData:[], energyColorArr:[])
    
    init(albumTracks:[TracksObject], trackDetails:Set<TrackFeaturesObject?>) {
        self.albumTracks = albumTracks
        self.trackDetails = trackDetails
    }
    
    
    func getChartData() {
        let tracksDetailArr = self.getSortedTracksDetailsArray()
        var tempEnergyArr:[EnergyChartViewModel] = []
        var energyColorArr:[Color] = []
        
        var minEnergy:Float = 101
        var maxEnergy:Float = -1
        var lowValCount = 0
        var midLowValCount = 0
        var neutralValCount = 0
        var midHighValCount = 0
        var highValCount = 0
        
        for eachTrack in tracksDetailArr {
    
            tempEnergyArr.append(EnergyChartViewModel(id:eachTrack.id, energy: Int(eachTrack.energy)))
            maxEnergy = eachTrack.energy > maxEnergy ? eachTrack.energy : maxEnergy
            minEnergy = eachTrack.energy < minEnergy ? eachTrack.energy : minEnergy
            
            switch intValencetoString(valence: eachTrack.valence) {
            case "Sad":
                lowValCount += 1
            case "Gloomy":
                midLowValCount += 1
            case "Neutral":
                neutralValCount += 1
            case "Upbeat":
                midHighValCount += 1
            case "Happy":
                highValCount += 1
            default:
                continue
            }
        }

        energyColorArr = getColorArrForEnergy(minValue: minEnergy, maxValue: maxEnergy)
        self.energyArr = (energyData:tempEnergyArr, energyColorArr:energyColorArr)
        self.musicalPositivityArr = [
            MusicalPositivity(positivity: "Sad", numTracks: lowValCount),
            MusicalPositivity(positivity: "Gloomy", numTracks: midLowValCount),
            MusicalPositivity(positivity: "Neutral", numTracks: neutralValCount),
            MusicalPositivity(positivity: "Upbeat", numTracks: midHighValCount),
            MusicalPositivity(positivity: "Happy", numTracks: highValCount)
        ]
        
    }
    
    private func getSortedTracksDetailsArray() -> [TrackFeaturesObject] {
        var trackFeaturesArr:[TrackFeaturesObject] = []
        for eachTrack in albumTracks {
            if let detailIndex = trackDetails.firstIndex(of: TrackFeaturesObject(withId: eachTrack.id)),
                let detailObj = trackDetails[detailIndex] {
                trackFeaturesArr.append(detailObj)
            }
        }
        self.trackDetails = []
        self.albumTracks = []
        return trackFeaturesArr
    }
    
}

