//
//  CurrentRunVCTests.swift
//  DreadmillTests
//
//  Created by Tobi Kuyoro on 26/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import XCTest
@testable import Dreadmill

class CurrentRunVCTests: XCTestCase {

    var currentRunVC: CurrentRunViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        currentRunVC = storyboard.instantiateViewController(withIdentifier: "CurrentRunViewController") as? CurrentRunViewController
        currentRunVC.loadViewIfNeeded()
    }

    override func tearDown() {
        currentRunVC = nil
        super.tearDown()
    }

    func testLocationInfoOnEntry() {
        XCTAssertNotNil(currentRunVC.manager?.location)
        XCTAssertNil(currentRunVC.startLocation, "Start location should be nil initially")
        XCTAssertNil(currentRunVC.lastLocation, "Last location should be nil initially")
        XCTAssertEqual(currentRunVC.locationsList.count, 0)
    }

    func testTimerLabelOnEntry(){
        let durationLabel = currentRunVC.durationLabel.text
        let startDuration = "00:00:00"
        XCTAssertEqual(durationLabel, startDuration, "Initally it's displayed that way because of the extension method on Int")
    }

    func testTimerLabelAfterTimerStarts() {
        currentRunVC.startRun()
        let durationLabel = currentRunVC.durationLabel.text
        let startDuration = "00:00:00"
        XCTAssertNotEqual(durationLabel, startDuration)
        XCTAssertNotNil(currentRunVC.timer)
        XCTAssertTrue(durationLabel?.count == 5,
                      "Once the timer fires, the count of the label should be 5, based on the extension method on Int")
    }

    func testPausingAndRestartingRun() {
        currentRunVC.pauseButton.sendActions(for: .touchUpInside)
        XCTAssertFalse(currentRunVC.timer.isValid)
        currentRunVC.pauseButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(currentRunVC.timer.isValid)
        XCTAssertEqual(currentRunVC.locationsList.count, 0)
    }


    func testTappingStopAddsRunToRealm() {
        let currentCount = currentRunVC.realmController.getAllRuns()?.count ?? 0
        currentRunVC.startRun()
        currentRunVC.stopButton.sendActions(for: .touchUpInside)

        guard let latestCount = currentRunVC.realmController.getAllRuns()?.count else {
            XCTFail("The running session wasn't saved. Something is wrong")
            return
        }
        
        XCTAssertNotEqual(currentCount, latestCount)
        XCTAssertGreaterThan(latestCount, currentCount)
    }
}
