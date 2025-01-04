//
//  LocationManager.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 11/12/2024.
//

import CoreLocation

@Observable
@MainActor
class LocationManager {
    private let manager: CLLocationManager
    var lastLocation = CLLocation()
    
    init() {
        self.manager = CLLocationManager()
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.manager.requestWhenInUseAuthorization()
    }
    
    func startLocationUpdates() {
        Task {
            do {
                let updates = CLLocationUpdate.liveUpdates()
                for try await update in updates {
                    if let location = update.location {
                        self.lastLocation = location
                    }
                }
            } catch {
                return print(error)
            }
        }
        manager.startUpdatingLocation()
    }
}
