//
//  CurrentRunViewController.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 23/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit
import MapKit

class CurrentRunViewController: LocationViewController {

    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var paceLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var pauseButton: CircularButton!

    // MARK: - Properties

    private var startLocation: CLLocation!
    private var lastLocation: CLLocation!
    private var timer = Timer()
    private var runDistance = 0.0
    private var counter = 0

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startRun()
    }

    // MARK: - Methods

    private func startRun() {
        manager?.startUpdatingLocation()
        manager?.distanceFilter = 10
        manager?.delegate = self
        startTimer()
    }

    private func endRun() {
        manager?.stopUpdatingLocation()
    }

    private func startTimer() {
        durationLabel.text = counter.timeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateCounter),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc private func updateCounter() {
        counter += 1
        durationLabel.text = counter.timeDurationToString()
    }

    // MARK: - IBActions

    @IBAction func stopButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }


    @IBAction func pauseButtonTapped(_ sender: Any) {
    }
}

extension CurrentRunViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkAuthStatus()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            distanceLabel.text = runDistance.metresToMiles(places: 2).description
        }

        lastLocation = locations.last
    }
}
