//
//  RunViewController.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 23/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class RunViewController: LocationViewController {

    @IBOutlet var mapView: MKMapView!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthStatus()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMapView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        manager?.stopUpdatingLocation()
    }

    // MARK: - Methods

    private func setupMapView() {
        if let overlay = addLastRun()  {
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }

            mapView.addOverlay(overlay)
        } else {
            centerMapOnUserLocation()
        }
    }

    private func addLastRun() -> MKPolyline? {
        guard let lastRun = realmController.getAllRuns()?.first else { return nil }

        var coordinates: [CLLocationCoordinate2D] = []

        for location in lastRun.locations {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            coordinates.append(coordinate)
        }

        let region = centerOnPreviousRun(locations: lastRun.locations)
        mapView.userTrackingMode = .none
        mapView.setRegion(region, animated: true)

        return MKPolyline(coordinates: coordinates, count: lastRun.locations.count)
    }

    private func centerMapOnUserLocation() {
        mapView.userTrackingMode = .follow

        let center = mapView.userLocation.coordinate
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }

    private func centerOnPreviousRun(locations: List<Location>) -> MKCoordinateRegion {
        guard let initialLocation = locations.first else { return MKCoordinateRegion() }
        var minLatitude = initialLocation.latitude
        var minLongitude = initialLocation.longitude
        var maxLatitude = minLatitude
        var maxLongitude = minLongitude

        for location in locations {
            minLatitude = min(minLatitude, location.latitude)
            minLongitude = min(minLongitude, location.longitude)
            maxLatitude = max(maxLatitude, location.latitude)
            maxLongitude = max(maxLongitude, location.longitude)
        }

        let latitude = (minLatitude + maxLatitude) / 2
        let longitude = (minLongitude + maxLongitude) / 2
        let latitudeDelta = (maxLatitude - minLatitude) * 1.4
        let longitudeDelta = (maxLongitude - minLongitude) * 1.4

        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                  span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta))
    }

    @IBAction func centerButtonTapped(_ sender: Any) {
        centerMapOnUserLocation()
    }
}

extension RunViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkAuthStatus()
            mapView.showsUserLocation = true
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyLine = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyLine)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 6
        return renderer
    }
}
