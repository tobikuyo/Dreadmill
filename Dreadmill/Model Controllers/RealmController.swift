//
//  RealmController.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 24/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation
import RealmSwift

class RealmController {

    var runDataConfiguration: Realm.Configuration {
        let fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?.appendingPathComponent(RealmConstants.configuration)

        let configuration = Realm.Configuration(fileURL: fileURL,
                                                schemaVersion: 0,
                                                migrationBlock: { migration, schemaVersion in
                                                    if schemaVersion < 0 {
                                                        // Realm will automatically detect new properties and remove properties
                                                    }
        })

        return configuration
    }

    func addRun(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        RealmConstants.queue.sync {
            let run = Run(pace: pace, distance: distance, duration: duration, locations: locations)

            do {
                let realm = try Realm(configuration: runDataConfiguration)
                try realm.write {
                    realm.add(run)
                    try realm.commitWrite()
                }
            } catch {
                NSLog("Error adding run to Realm: \(error)")
            }
        }
    }

    func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm(configuration: runDataConfiguration)
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            return runs
        } catch {
            return nil
        }
    }
}
