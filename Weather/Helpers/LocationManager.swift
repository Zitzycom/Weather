//
//  LocationManager.swift
//  Weather
//
//  Created by Macbook on 18.12.2023.
//

import CoreLocation
import Combine
import Foundation

class LocationManager: NSObject, CLLocationManagerDelegate {
    //MARK: - Properties
    private let manager = CLLocationManager()
    @Published var location: CLLocation?
    //MARK: - Init
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    //MARK: - Ptivate metods
    private func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    //MARK: - Delegate metods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
