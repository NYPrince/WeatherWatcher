//
//  Configuration.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/2/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation
import CoreLocation

enum Defaults {
    
    
    static let location = CLLocation(latitude: 40.7127, longitude: -74.0059)
    
}

enum WeatherService {
  private  static var apiKey = "2523023f1cb6a651fd5ed31fed08244b"
  private  static var baseUrl = URL(string: "https://darksky.net/forecast")!
    static var authenticatedBaseUrl:URL {
        return baseUrl.appendingPathComponent(apiKey)
    }
}
