//
//  DreadmillUITests.swift
//  DreadmillUITests
//
//  Created by Tobi Kuyoro on 27/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import XCTest

class DreadmillUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testTappingStartButton() {
        XCTAssertTrue(app.isDisplayingRunVC)
        app.buttons["START"].tap()
        XCTAssertTrue(app.isDisplayingCurrentRunVC)
    }

    func testTappingCenterButton() {
        XCTAssertTrue(app.isDisplayingRunVC)
        app.buttons["compass"].tap()
    }

    func testLabelsInCurrentRunVC() {
        XCTAssertTrue(app.isDisplayingRunVC)
        app.buttons["START"].tap()
        XCTAssertTrue(app.isDisplayingCurrentRunVC)
        XCTAssertTrue(app.staticTexts["CURRENT TIME"].exists)
        XCTAssertTrue(app.staticTexts["00:00"].exists)
        XCTAssertTrue(app.staticTexts["AVERAGE PACE"].exists)
        XCTAssertTrue(app.staticTexts["00:00"].exists)
        XCTAssertTrue(app.staticTexts["PER MILE"].exists)
        XCTAssertTrue(app.staticTexts["DISTANCE"].exists)
        XCTAssertTrue(app.staticTexts["00.00"].exists)
        XCTAssertTrue(app.staticTexts["MILES"].exists)
    }

    func testTappingPauseAndStopButtons() {
        XCTAssertTrue(app.isDisplayingRunVC)
        app.buttons["START"].tap()
        XCTAssertTrue(app.isDisplayingCurrentRunVC)
        app/*@START_MENU_TOKEN@*/.buttons["pause.fill"]/*[[".otherElements[\"CurrentRunViewController\"].buttons[\"pause.fill\"]",".buttons[\"pause.fill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["stop.fill"]/*[[".otherElements[\"CurrentRunViewController\"].buttons[\"stop.fill\"]",".buttons[\"stop.fill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.isDisplayingRunVC)
    }

    func testDeletingRunSession() {
        XCTAssertTrue(app.isDisplayingRunVC)
        app.tabBars.buttons["PERFORMANCE"].tap()
        XCTAssertTrue(app.isDisplayingRunLogVC)

        let cells = app.tables.cells
        let firstCell = cells.element(boundBy: 0)
        guard cells.count > 1 else {
            XCTFail("There are no running sessions yet.")
            return
        }

        firstCell.swipeLeft()
        firstCell.buttons["Delete"].tap()
    }
}

extension XCUIApplication {
    var isDisplayingRunVC: Bool {
        return otherElements["RunViewController"].exists
    }

    var isDisplayingCurrentRunVC: Bool {
        return otherElements["CurrentRunViewController"].exists
    }

    var isDisplayingRunLogVC: Bool {
        return otherElements["RunLogViewController"].exists
    }
}
