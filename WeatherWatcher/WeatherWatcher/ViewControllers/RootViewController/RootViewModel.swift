//
//  RootViewModel.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/3/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation

class RootViewModel {
    
    enum WeatherDataError: Error {
        case noWeatherDataAvailable
    }
    
    
    typealias DidFetchWeatherDataCompletion = (WeatherData?, WeatherDataError?) ->Void
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    init() {
        fetchWeatherData()
    }
    
    private func fetchWeatherData(){
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
        
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self](data, response, error) in
            if let response = response as? HTTPURLResponse{
                print("Status Code: \(response.statusCode)")
            }
            if error != nil {
                print("Uable to fetch Weather data \(error)")
                self?.didFetchWeatherData?(nil, .noWeatherDataAvailable )
            }else if let data = data {
                let decoder = JSONDecoder()
                
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
            
            }.resume()
    }
    
}
