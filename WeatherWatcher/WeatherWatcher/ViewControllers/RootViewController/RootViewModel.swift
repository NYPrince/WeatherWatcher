//
//  RootViewModel.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/3/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation

class RootViewModel {
    
    typealias DidFetchWeatherDataCompletion = (Data?, Error?) ->Void
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    init() {
        fetchWeatherData()
    }
    
    private func fetchWeatherData(){
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
        URLSession.shared.dataTask(with: weatherRequest.url) { (data, response, error) in
            if error != nil {
                self.didFetchWeatherData?(nil, error )
            }else if let data = data {
                self.didFetchWeatherData?(data, nil)
            } else{
                self.didFetchWeatherData?(nil, nil)
            }
            
            }.resume()
    }
    
    
    
}
