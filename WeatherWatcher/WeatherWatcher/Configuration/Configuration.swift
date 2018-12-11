//
//  Configuration.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/2/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation


enum Defaults {
    
    
    static let location = Location(latitude: 40.7127, longitude: -74.0059)
    
}

enum WeatherService {
  private  static var apiKey = "eb1b7b2e761f6459f17a59985f16df15"
  private  static var baseUrl = URL(string: "https://api.darksky.net/forecast")!
    static var authenticatedBaseUrl:URL {
        return baseUrl.appendingPathComponent(apiKey)
    }
}
