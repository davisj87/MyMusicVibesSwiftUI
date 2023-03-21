//
//  UIColor+Extension.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
