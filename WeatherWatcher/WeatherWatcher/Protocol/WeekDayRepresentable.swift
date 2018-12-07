//
//  WeekDayRepresentable.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 12/1/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import UIKit

protocol WeekDayRepresentable {
    
    var day:String {get}
    var date:String {get}
    var temperature:String {get}
    var windSpeed:String {get}
    var image:UIImage? {get}
    
}
