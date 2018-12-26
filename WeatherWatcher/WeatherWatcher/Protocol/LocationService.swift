//
//  LocationService.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 12/8/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation

enum LocationServiceError:Error {
    case notAuthorizedToRequestLocation
}
enum LocationServiceResult {
    case success(Location)
    case failure(LocationServiceError)
}

protocol LocationService {
    
    typealias FetchLocationCompletion = (LocationServiceResult)-> Void
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
