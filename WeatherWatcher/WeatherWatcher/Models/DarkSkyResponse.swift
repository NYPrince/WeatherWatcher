//
//  DarkSkyResponse.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/8/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation

 struct DarkSkyResponse: Codable {
    
     struct Conditions: Codable {
        let time : Date
        let icon : String
        let summary : String
        let windSpeed : Double
        let temperature : Double
    }
    
    struct Daily: Codable {
        struct Conditions: Codable {
            let time: Date
            let icon: String
            let windSpeed: Double
            let temperatureMin: Double
            let temperatureMax: Double
        }
    }
    
    let latitude : Double
    let longitude : Double
    
    let currently : Conditions
    let daily: Daily
    
}
