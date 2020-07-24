//
//  Location.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 24/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0

    convenience init (latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
