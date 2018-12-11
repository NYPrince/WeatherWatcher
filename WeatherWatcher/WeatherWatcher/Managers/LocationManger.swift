//
//  LocationManger.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 12/9/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager:NSObject, LocationService{
    
    private lazy var locationManager: CLLocationManager = {
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private var didFetchLocation: FetchLocationCompletion?
    
    
    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        didFetchLocation = completion
        
        locationManager.requestLocation()
        
    }
}
extension LocationManager:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            
        }else if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }else {
            didFetchLocation?(nil, .notAuthorizedToRequestLocation )
            didFetchLocation = nil
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        didFetchLocation?(Location(location: location), nil)
        didFetchLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("unable to get location")
    }
}
fileprivate extension Location{
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
    }
}







