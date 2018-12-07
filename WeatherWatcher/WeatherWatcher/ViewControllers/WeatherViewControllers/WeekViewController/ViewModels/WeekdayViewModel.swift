//
//  WeekdayViewModel.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 12/1/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import UIKit

struct WeekDayViewModel {
    
    let weatherData: ForecastWeatherConditions
    
    private let dateFormatter = DateFormatter()
    
    var day: String{
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: weatherData.time )
    }
    var date: String{
        dateFormatter.dateFormat = "MMMM d "
        return dateFormatter.string(from: weatherData.time )
    }
    var temperature: String {
        let min = String(format: "%.1f °F", weatherData.temperatureMin)
        let max = String(format: "%.1f °F", weatherData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    var windSpeed: String {
        return String(format: "%, F MPH", weatherData.windSpeed)
    }
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
}
extension WeekDayViewModel: WeekDayRepresentable{
    
}




