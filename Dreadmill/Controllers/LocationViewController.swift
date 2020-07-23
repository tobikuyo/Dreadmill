//
//  LocationViewController.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 23/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    var manager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerSetup()
    }
}

extension LocationViewController: MKMapViewDelegate {
    func checkAuthStatus() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            manager?.requestWhenInUseAuthorization()
        }
    }

    func locationManagerSetup() {
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
    }
}
