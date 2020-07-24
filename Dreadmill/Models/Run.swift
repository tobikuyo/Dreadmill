//
//  Run.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 24/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {
    @objc dynamic var id = ""
    @objc dynamic var date = Date()
    @objc dynamic var pace = 0
    @objc dynamic var distance = 0.0
    @objc dynamic var duration = 0
    var locations = List<Location>()

    override static func primaryKey() -> String? {
        return "id"
    }

    override static func indexedProperties() -> [String] {
        return ["date", "pace", "duration"]
    }

    convenience init(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.id = UUID().uuidString
        self.date = Date()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.locations = locations
    }
}
