//
//  Weatherdata.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/9/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation
protocol WeatherData {
    var latitude: Double {get}
    var longitude: Double {get}
    
    var current:CurrentWeatherCondtions {get}
    var forecast: [ForecastWeatherConditions] {get}
}


protocol WeatherConditions {
    var time : Date {get}
    var icon : String {get}
    var windSpeed : Double {get}
}


protocol CurrentWeatherCondtions: WeatherConditions {
    
    var summary : String {get}
    var temperature : Double {get}
}
protocol ForecastWeatherConditions: WeatherConditions {
    
    var temperatureMin: Double {get}
    var temperatureMax: Double {get}
    
}





