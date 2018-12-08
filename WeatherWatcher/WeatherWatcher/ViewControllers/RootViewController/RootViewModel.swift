//
//  RootViewModel.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/3/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation
import CoreLocation

class RootViewModel: NSObject {
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case noWeatherDataAvailable
        
    }
    
    typealias DidFetchWeatherDataCompletion = (WeatherData?, WeatherDataError?) ->Void
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    private lazy var locationManager: CLLocationManager = {
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    
    override init() {
        super.init()
        fetchWeatherData(for: Defaults.location)
        
        fetchLocation()
    }
    
    private func fetchLocation (){
        locationManager.requestLocation()
    }
    
    private func fetchWeatherData(for: CLLocation ){
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
        
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self](data, response, error) in
            if let response = response as? HTTPURLResponse{
                print("Status Code: \(response.statusCode)")
            }
            DispatchQueue.main.async {
                if error != nil {
                    print("Uable to fetch Weather data \(String(describing: error))")
                    self?.didFetchWeatherData?(nil, .noWeatherDataAvailable )
                }else if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self
                            , from: data)
                        self?.didFetchWeatherData?(darkSkyResponse, nil)
                        
                    }catch{
                        print("Unable to decode JSON \(error) ")
                        
                        self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                    }
                    
                } else{
                    self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                }
            }
            
        }.resume()
    }
    
}
extension RootViewModel:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if status == .authorizedWhenInUse {
            fetchLocation()
        }else {
            didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        fetchWeatherData(for: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("unable to get location")
    }
}








