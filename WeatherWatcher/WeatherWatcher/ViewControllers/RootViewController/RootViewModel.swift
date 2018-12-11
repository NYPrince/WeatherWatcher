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
        case failedToRequestLocation
        case noWeatherDataAvailable
        
    }
    
    typealias DidFetchWeatherDataCompletion = (WeatherData?, WeatherDataError?) ->Void
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    private let locationService: LocationService
    
    
    init(locationService: LocationService ) {
        self.locationService = locationService
        super.init()
        fetchWeatherData(for: Defaults.location)
        
        fetchLocation()
    }
    
    private func fetchLocation (){
        locationService.fetchLocation { [weak self](location, error) in
            
            if let error = error {
                
                print("Unable to Fetch Location (\(error))")
                
                self?.didFetchWeatherData?(nil, .notAuthorizedToRequestLocation )
            } else {
                print("Unable to Fetch Location")
                
                 self?.didFetchWeatherData?(nil, .failedToRequestLocation)
            }
            if let location = location {
                self?.fetchWeatherData(for: location)
            }else{
                print("unable to fetch location")
                self?.didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
            }
        }
    }
    
    private func fetchWeatherData(for: Location ){
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








