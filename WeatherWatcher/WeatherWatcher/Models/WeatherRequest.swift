//
//  WeatherRequest.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/2/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation


struct WeatherRequest {
    
    
    let baseUrl:URL
    let location:Location
    
    private var latitude: Double{
        return location.latitude
    }
    private var longtitude:Double {
        return location.longitude
    }
    
    var url: URL{
        return baseUrl.appendingPathComponent("\(latitude), \(longtitude)")
    }
}
