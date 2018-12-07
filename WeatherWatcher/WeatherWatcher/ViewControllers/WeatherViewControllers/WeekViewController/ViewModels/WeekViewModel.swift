//
//  WeekViewModel.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/9/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation

struct WeekViewModel {
    
    let weatherData : [ForecastWeatherConditions]
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeekDayViewModel {
        return WeekDayViewModel(weatherData: weatherData[index])
    }
}
