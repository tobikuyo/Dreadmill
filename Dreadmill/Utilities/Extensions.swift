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
