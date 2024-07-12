//
//  LocationManager.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/12/24.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocations(lat: Double, lon: Double)
    func didFailWithError(error: Error)
}

final class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    func startUpdatingLocation() {
            locationManager.startUpdatingLocation()
        }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            delegate?.didUpdateLocations(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            delegate?.didFailWithError(error: error)
        }
}
