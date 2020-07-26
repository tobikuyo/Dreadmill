//
//  RealmControllerTests.swift
//  DreadmillTests
//
//  Created by Tobi Kuyoro on 26/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Dreadmill

class RealmControllerTests: XCTestCase {

    var realmController: RealmController!

    override func setUp() {
        super.setUp()
        realmController = RealmController()
    }

    override func tearDown() {
        realmController = nil
        super.tearDown()
    }

    func testAddingToRealm() {
        let currentCount = realmController.getAllRuns()?.count ?? 0
        realmController.addRun(pace: 0, distance: 0.0, duration: 0, locations: List<Location>())
        guard let latestCount = realmController.getAllRuns()?.count else { return }
        XCTAssertGreaterThan(latestCount, 0, "There should be at least 1 run session now")
        XCTAssertNotEqual(currentCount, latestCount)
    }

    func testAddingToRealmPerformance() {
        measure {
            realmController.addRun(pace: 0, distance: 0.0, duration: 0, locations: List<Location>())
        }
    }

    func testDeletingRunFromRealm() {
        let runs = realmController.getAllRuns()
        let run = runs?.first
        realmController.delete(run: run)
    }
}
