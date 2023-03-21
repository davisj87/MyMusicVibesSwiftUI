//
//  TrackFeaturesObject.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

// Needed when calling for multiple tracks
struct TrackAudioFeatures: Decodable {      //<T:Decodable>
    var audioFeatures: Set<TrackFeaturesObject?>
    
    private enum CodingKeys: String, CodingKey {
        case audioFeatures = "audio_features"
    }
}
extension TrackAudioFeatures {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.audioFeatures = try container.decodeIfPresent(Set<TrackFeaturesObject?>.self, forKey: .audioFeatures) ?? Set<TrackFeaturesObject>()
    }
}

//Use this when getting data for a single track at a time
struct TrackFeaturesObject: Decodable {
    var id: String
    var danceability: Float
    var energy: Float
    var key: Int
    var loudness: Float
    var mode: Int
    var speechiness: Float
    var acousticness: Float
    var instrumentalness: Double
    var liveness: Float
    var valence: Float
    var tempo: Double
    var timeSignature: Int
    
    
    private enum CodingKeys: String, CodingKey {
        case danceability, energy, key,
             loudness, mode, speechiness,
             acousticness, instrumentalness, liveness,
             valence, tempo, id
        case timeSignature = "time_signature"
    }
}

extension TrackFeaturesObject: Hashable {
    static func == (lhs: TrackFeaturesObject, rhs: TrackFeaturesObject) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TrackFeaturesObject {
    init(withId id: String) {
        self.id = id
        self.danceability = 0
        self.energy = 0
        self.key = 0
        self.loudness = 0
        self.mode = 0
        self.speechiness = 0
        self.acousticness = 0
        self.instrumentalness = 0
        self.liveness = 0
        self.valence = 0
        self.tempo = 0
        self.timeSignature = 0
    }
}

extension TrackFeaturesObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        
        /* Danceability describes how suitable a track is for dancing based on a combination of
         musical elements including tempo, rhythm stability, beat strength, and overall regularity.
         A value of 0.0 is least danceable and 1.0 is most danceable.*/
        let danceability = try container.decodeIfPresent(Float.self, forKey: .danceability) ?? -1
        self.danceability = danceability * 100
        
        
        /* Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity.
         Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy,
         while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute
         include dynamic range, perceived loudness, timbre, onset rate, and general entropy.*/
        let energy = try container.decodeIfPresent(Float.self, forKey: .energy) ?? -1
        self.energy = energy * 100
        
        /* The key the track is in. Integers map to pitches using standard Pitch Class notation.
         E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on. If no key was detected, the value is -1.*/
        self.key = try container.decodeIfPresent(Int.self, forKey: .key) ?? -2
        
        /* The overall loudness of a track in decibels (dB). Loudness values are averaged across
         the entire track and are useful for comparing relative loudness of tracks. Loudness is the
         quality of a sound that is the primary psychological correlate of physical strength (amplitude).
         Values typically range between -60 and 0 db.*/
        self.loudness = try container.decodeIfPresent(Float.self, forKey: .loudness) ?? -0
        
        
        /* Mode indicates the modality (major or minor) of a track, the type of scale from which its
         melodic content is derived. Major is represented by 1 and minor is 0.*/
        self.mode = try container.decodeIfPresent(Int.self, forKey: .mode) ?? -1
        
        /* Speechiness detects the presence of spoken words in a track. The more exclusively speech-like
         the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value.
         Values above 0.66 describe tracks that are probably made entirely of spoken words.
         Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections
         or layered, including such cases as rap music. Values below 0.33 most likely represent music and other
         non-speech-like tracks.*/
        let speechiness = try container.decodeIfPresent(Float.self, forKey: .speechiness) ?? -1
        self.speechiness =  speechiness * 100
        
        /* A confidence measure from 0.0 to 1.0 of whether the track is acoustic.
         1.0 represents high confidence the track is acoustic.*/
        let acousticness = try container.decodeIfPresent(Float.self, forKey: .acousticness) ?? -1
        self.acousticness = acousticness * 100
        
        /* Predicts whether a track contains no vocals. "Ooh" and "aah" sounds are treated as instrumental in this context.
         Rap or spoken word tracks are clearly "vocal". The closer the instrumentalness value is to 1.0, the greater
         likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks,
         but confidence is higher as the value approaches 1.0.*/
        let instrumentalness = try container.decodeIfPresent(Double.self, forKey: .instrumentalness) ?? -1
        self.instrumentalness = instrumentalness * 100
        
        /* Detects the presence of an audience in the recording. Higher liveness values represent an increased probability
         that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.*/
        let liveness = try container.decodeIfPresent(Float.self, forKey: .liveness) ?? -1
        self.liveness = liveness * 100
        
        /* A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track.
        Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric),
        while tracks with low valence sound more negative (e.g. sad, depressed, angry). */
        let valence = try container.decodeIfPresent(Float.self, forKey: .valence) ?? -1
        self.valence = valence * 100
        
        /* The overall estimated tempo of a track in beats per minute (BPM). In musical terminology,
         tempo is the speed or pace of a given piece and derives directly from the average beat duration.*/
        self.tempo = try container.decodeIfPresent(Double.self, forKey: .tempo) ?? -1
        
        /* An estimated time signature. The time signature (meter) is a notational convention to specify how many beats
         are in each bar (or measure). The time signature ranges from 3 to 7 indicating time signatures of "3/4", to "7/4".*/
        self.timeSignature = try container.decodeIfPresent(Int.self, forKey: .timeSignature) ?? -1

    }
}
