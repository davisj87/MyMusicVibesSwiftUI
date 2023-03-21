//
//  JSONUtilities.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

extension Data {
    var JSONObject: Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: [])
        } catch {
            //print("Problem de-serializing object: \(error)")
        }
        return nil
    }
}

extension Dictionary {
    var JSONString: String? {
        guard let data = self.JSONData else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    var JSONData: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            //print("Problem de-serializing object: \(error)")
        }
        return nil
    }
}
