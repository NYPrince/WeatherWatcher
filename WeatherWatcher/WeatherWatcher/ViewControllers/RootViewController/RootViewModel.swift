//
//  RootViewModel.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/3/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import Foundation


class RootViewModel: NSObject {
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
        
    }
    
    enum WeatherDataResult {
        case success(WeatherData)
        case failure(WeatherDataError)
    }
    
    
    typealias FetchWeatherDataCompletion = (WeatherDataResult) ->Void
    
    var didFetchWeatherData: FetchWeatherDataCompletion?
    
    private let locationService: LocationService
    
    
    init(locationService: LocationService ) {
        self.locationService = locationService
        super.init()
        fetchWeatherData(for: Defaults.location)
        
        setupNoticationaHandling()
        fetchLocation()
    }
    
    private func fetchLocation() {
        locationService.fetchLocation { [weak self] (result) in
            switch result {
            case .success(let location):
                // Fetch Weather Data
                self?.fetchWeatherData(for: location)
            case .failure(let error):
                print("Unable to Fetch Location (\(error))")
                
                let result:WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                
                // Invoke Completion Handler
                self?.didFetchWeatherData?(result)
            }
        }
    }
        

    private func fetchWeatherData(for: Location ){
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
        
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self](data, response, error) in
            if let response = response as? HTTPURLResponse{
                print("Status Code: \(response.statusCode)")
            }
            DispatchQueue.main.async {
                if error != nil {
                    print("Uable to fetch Weather data \(String(describing: error))")
                      let result:WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                    
                    self?.didFetchWeatherData?(result)
                }else if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self
                            , from: data)
                       let result:WeatherDataResult = .success(darkSkyResponse)
                        UserDefaults.didFetchWeatherData = Date()
                        
                        self?.didFetchWeatherData?(result)
                        
                    }catch{
                        print("Unable to decode JSON \(error) ")
                        
                        let result:WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                    }
                    
                } else{
                    let result:WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                }
            }
            
        }.resume()
    }
    
    private func setupNoticationaHandling(){
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillEnterForeground, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            guard let didFetchWeatherData = UserDefaults.didFetchWeatherData else{
                
                self?.refresh()
                return
            }
            if Date().timeIntervalSince(didFetchWeatherData) > Configuration.refreshThreshold {
                self?.refresh()
            }
            
        }
        
    }
     func refresh(){
        fetchLocation()
        
    }
    
}
extension UserDefaults{
    private enum Keys {
        static let didFetchWeatherData = "didFetchWeatherData"
    }
    fileprivate class var didFetchWeatherData: Date? {
        get{
         
            return UserDefaults.standard.object(forKey: Keys.didFetchWeatherData) as? Date
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.didFetchWeatherData)
        }
    }
}




















