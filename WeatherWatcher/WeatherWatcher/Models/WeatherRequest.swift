//
//  WeatherRequest.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/2/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    
    
    let baseUrl:URL
    let location:CLLocation
    
    private var latitude: Double{
        return location.coordinate.latitude
    }
    private var longtitude:Double {
        return location.coordinate.longitude
    }
    
    var url: URL{
        return baseUrl.appendingPathComponent("\(latitude), \(longtitude)")
    }
}
