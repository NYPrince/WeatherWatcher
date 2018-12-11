//
//  LocationService.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 12/8/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation

enum LocationServiceError {
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    
    typealias FetchLocationCompletion = (Location?, LocationServiceError?)-> Void
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
