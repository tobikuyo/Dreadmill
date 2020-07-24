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
    private var duration = 0
    private var pace = 0

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

    private func pauseRun() {
        manager?.stopUpdatingLocation()
        timer.invalidate()
        startLocation = nil
        lastLocation = nil
    }

    private func endRun() {
        manager?.stopUpdatingLocation()
        realmController.addRun(pace: pace, distance: runDistance, duration: duration)
    }

    private func startTimer() {
        durationLabel.text = duration.timeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateCounter),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc private func updateCounter() {
        duration += 1
        durationLabel.text = duration.timeDurationToString()
    }

    private func calculatePace(time seconds: Int, miles: Double) -> String {
        pace = Int(Double(seconds) / miles)
        return pace.timeDurationToString()
    }

    // MARK: - IBActions

    @IBAction func stopButtonTapped(_ sender: Any) {
        endRun()
        navigationController?.popViewController(animated: true)
    }


    @IBAction func pauseButtonTapped(_ sender: Any) {
        pauseButton.isSelected.toggle()
        pauseButton.isSelected ? pauseRun() : startRun()
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

            if duration > 0 && runDistance > 0 {
                paceLabel.text = calculatePace(time: duration, miles: runDistance.metresToMiles(places: 2))
            }
        }

        lastLocation = locations.last
    }
}