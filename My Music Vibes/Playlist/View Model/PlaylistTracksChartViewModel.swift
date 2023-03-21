//
//  PlaylistTracksChartViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import SwiftUI

class PlaylistTracksChartViewModel: ObservableObject, TrackDetailViewFormatter, TracksChartDetailViewFormatter {
    
    private var playlistTracks:[PlaylistTrackObject]
    private var trackDetails:Set<TrackFeaturesObject?>
    
    @Published var musicalPositivityArr:[MusicalPositivity] = []
    @Published var energyArr:(energyData:[EnergyChartViewModel], energyColorArr:[Color]) = (energyData:[], energyColorArr:[])
    
    init(playlistTracks:[PlaylistTrackObject], trackDetails:Set<TrackFeaturesObject?>) {
        self.playlistTracks = playlistTracks
        self.trackDetails = trackDetails
    }
    
    
    func getChartData() {
        let tracksDetailArr = self.getSortedTracksDetailsArray()
       
        // Local properties needed to generate Energy Chart
        var tempEnergyArr:[EnergyChartViewModel] = []
        var energyColorArr:[Color] = []
        var minEnergy:Float = 101
        var maxEnergy:Float = -1
        
        // Local properties needed to generate Musical Positivity Chart
        var lowValCount = 0
        var midLowValCount = 0
        var neutralValCount = 0
        var midHighValCount = 0
        var highValCount = 0
        
        for eachTrack in tracksDetailArr {
    
            tempEnergyArr.append(EnergyChartViewModel(id:eachTrack.id, energy: Int(eachTrack.energy)))
            
            /* Use this to find the final max and min energy levels of the playlist or album.
             We will use these values later to determine what colors to use in our energy line chart
             */
            maxEnergy = eachTrack.energy > maxEnergy ? eachTrack.energy : maxEnergy
            minEnergy = eachTrack.energy < minEnergy ? eachTrack.energy : minEnergy
            
            
            // Based on the Valence (Musical Pos.) range we populate the values of the Positivity chart.
            switch Int(eachTrack.valence) {
            case 0...20:
                lowValCount += 1
            case 21...45:
                midLowValCount += 1
            case 46...55:
                neutralValCount += 1
            case 56...79:
                midHighValCount += 1
            case 80...100:
                highValCount += 1
            default:
                continue
            }

        }

        // Based on the min and max energy values we got from the for loop we determine the color array we should use for the chart.
        energyColorArr = self.getColorArrForEnergy(minValue: minEnergy, maxValue: maxEnergy)
        self.energyArr = (energyData:tempEnergyArr, energyColorArr:energyColorArr)
        
        self.musicalPositivityArr = [
            MusicalPositivity(positivity: "Sad", numTracks: lowValCount),
            MusicalPositivity(positivity: "Gloomy", numTracks: midLowValCount),
            MusicalPositivity(positivity: "Neutral", numTracks: neutralValCount),
            MusicalPositivity(positivity: "Upbeat", numTracks: midHighValCount),
            MusicalPositivity(positivity: "Happy", numTracks: highValCount)
        ]
        
    }
    
    
    /*  This function gets the track features of each track in the proper order. For example an album
        has tracks in a specific order and the same is true for a playlist so the chart should have the tracks in the
        same order.
     */
    private func getSortedTracksDetailsArray() -> [TrackFeaturesObject] {
        var trackFeaturesArr:[TrackFeaturesObject] = []
        for eachTrack in playlistTracks {
            if let detailIndex = trackDetails.firstIndex(of: TrackFeaturesObject(withId: eachTrack.track.id)),
                let detailObj = trackDetails[detailIndex] {
                trackFeaturesArr.append(detailObj)
            }
        }
        
        /*  Once this function returns the track features array in the proper order we no longer need the trackDetails,
            or playlistTracks we initalized with
         */
        self.trackDetails = []
        self.playlistTracks = []
        return trackFeaturesArr
    }
    
}



struct EnergyChartViewModel:Identifiable {
    let id:String
    let energy:Int
    let color:UIColor = .random
}

struct MusicalPositivity:Identifiable {
    let id = UUID()
    let positivity:String
    let numTracks:Int
}

struct MusicalPositivityDisplayData {
    static let musicalPosArr:[MusicalPositivity] = [
        MusicalPositivity(positivity: "Sad", numTracks: 1),
        MusicalPositivity(positivity: "Gloomy", numTracks: 2),
        MusicalPositivity(positivity: "Neutral", numTracks: 3),
        MusicalPositivity(positivity: "Upbeat", numTracks: 2),
        MusicalPositivity(positivity: "Happy", numTracks: 1)
    ]
}
/**
 
 func intValencetoString(valence:Float) -> String {
     /* A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track.
     Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric),
     while tracks with low valence sound more negative (e.g. sad, depressed, angry). */
     switch Int(valence) {
     case 0...20:
         return "Sad"
     case 21...45:
         return "Gloomy"
     case 46...55:
         return "Neutral"
     case 56...79:
         return "Upbeat"
     case 80...100:
         return "Happy"
     default:
         return "Undefined"
     }
 }
 
 */
