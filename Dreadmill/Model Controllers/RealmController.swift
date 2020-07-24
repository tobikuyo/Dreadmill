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

    func addRun(pace: Int, distance: Double, duration: Int) {
        RealmQueue.label.sync {
            let run = Run(pace: pace, distance: distance, duration: duration)

            do {
                let realm = try Realm()
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
            let realm = try Realm()
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            return runs
        } catch {
            return nil
        }
    }
}
