//
//  CurrentLocation.swift
//  WeatherAppSwift
//
//  Created by Naman Dhiman on 27/11/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    private var locationManager = CLLocationManager()
    
    @Published var currentLocation: CLLocation?
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else{return}
        currentLocation = newLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user last location \(error.localizedDescription)")
    }
    
}
