//
//  Extensions.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 23/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

extension Double {
    func metresToMiles(places: Int) -> Double {
        let divisor = pow(10, Double(places))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
}

extension Int {
    func timeDurationToString() -> String {
        let durationInHours = self / 3600
        let durationInMinutes = (self % 3600) / 60
        let durationInSeconds = (self % 3600) % 60

        if durationInSeconds < 0 {
            return "00:00:00"
        } else if durationInHours == 0 {
            return String(format: "%02d:%02d", durationInMinutes, durationInSeconds)
        } else {
            return String(format: "%02d:%02d:%02d", durationInHours, durationInMinutes, durationInSeconds)
        }
    }
}
