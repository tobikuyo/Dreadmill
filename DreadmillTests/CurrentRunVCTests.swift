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
}
