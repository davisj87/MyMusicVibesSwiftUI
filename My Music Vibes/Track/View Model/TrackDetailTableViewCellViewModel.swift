//
//  TrackDetailTableViewCellViewModel.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation


struct TrackDetailTableViewCellViewModel: TrackDetailViewFormatter {
    private (set) var track:TrackOverviewCellViewModel?
    private (set) var trackDetail:TrackFeaturesObject?
    
    let id = UUID()
    var name:String = ""
    var artist:String = ""
    var popularity:String = ""
    var imageUrl:String = ""
    
    var valence:TrackDetailAttribute = TrackDetailAttribute(name: "Valence", value: "")
    var dancability:TrackDetailAttribute = TrackDetailAttribute(name: "Dancability", value: "")
    var keyMode:TrackDetailAttribute = TrackDetailAttribute(name: "Key", value: "")
    
    init(track:TrackOverviewCellViewModel?, trackDetail:TrackFeaturesObject?) {
        self.track = track
        self.trackDetail = trackDetail
        if let track = track {
            self.name = track.primaryText
            self.artist = track.secondaryText
            self.popularity = track.popularity
            self.imageUrl = track.imageUrl
        }
        
        if let trackDetail = trackDetail {
            let valenceVal = self.intValencetoString(valence: trackDetail.valence)
            self.valence = TrackDetailAttribute(name: "Valence", value: valenceVal)
            let danceVal = String(Int(trackDetail.danceability))
            self.dancability = TrackDetailAttribute(name: "Dancability", value: danceVal)
            
            let keyString = self.intKeytoString(key: trackDetail.key)
            let modeString = self.intModetoString(mode: trackDetail.mode)
            let keyMode = keyString + " " + modeString
            self.keyMode =  TrackDetailAttribute(name: "Key", value: keyMode)
        }
        
    }
}

extension TrackDetailTableViewCellViewModel: Hashable {
    static func == (lhs: TrackDetailTableViewCellViewModel, rhs: TrackDetailTableViewCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TrackDetailAttribute {
    var name:String
    var value:String
}

protocol TrackDetailViewFormatter {}

extension TrackDetailViewFormatter {
    func intKeytoString(key:Int) -> String {
        switch key {
        case 0:
            return "C"
        case 1:
            return "Db"
        case 2:
            return "D"
        case 3:
            return "Eb"
        case 4:
            return "E"
        case 5:
            return "F"
        case 6:
            return "F#"
        case 7:
            return "G"
        case 8:
            return "Ab"
        case 9:
            return "A"
        case 10:
            return "Bb"
        case 11:
            return "B"
        default:
            return "N/A"
        }
    }
    
    func intModetoString(mode:Int) -> String {
        switch mode {
        case 0:
            return "Minor"
        case 1:
            return "Major"
        default:
            return "N/A"
        }
    }
    
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
}
