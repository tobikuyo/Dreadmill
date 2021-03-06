//
//  CurrentRunViewController.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 23/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class CurrentRunViewController: LocationViewController {

    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var paceLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var pauseButton: CircularButton!
    @IBOutlet var stopButton: CircularButton!

    // MARK: - Properties

    private(set) var startLocation: CLLocation!
    private(set) var lastLocation: CLLocation!
    private(set) var timer = Timer()
    private(set) var locationsList = List<Location>()

    private(set) var runDistance = 0.0
    private(set) var duration = 0
    private(set) var pace = 0

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "CurrentRunViewController"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startRun()
    }

    // MARK: - Methods

    func startRun() {
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
        realmController.addRun(pace: pace, distance: runDistance, duration: duration, locations: locationsList)
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

            let latitude = lastLocation.coordinate.latitude
            let longitude = lastLocation.coordinate.longitude
            let newLocation = Location(latitude: latitude, longitude: longitude)
            locationsList.insert(newLocation, at: 0)

            if duration > 0 && runDistance > 0 {
                paceLabel.text = calculatePace(time: duration, miles: runDistance.metresToMiles(places: 2))
            }
        }

        lastLocation = locations.last
    }
}
