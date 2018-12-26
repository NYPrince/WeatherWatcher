//
//  RootViewController.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/1/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum AlertType{
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
        
    }
    
    var viewModel : RootViewModel?{
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }
    
    //MARK: - Properties
    
    private let dayViewController: DayViewController = {
        guard let dayViewController = UIStoryboard.main.instantiateViewController(withIdentifier: DayViewController.StoryboardIndentifier) as? DayViewController else{
            fatalError("Unable to instantiate Day View Controller")
        }
        //configure Day View Controller
        dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return dayViewController
    }()
    
    private lazy var weekViewController: WeekViewController = {
        guard let weekViewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.StoryboardIndentifier) as? WeekViewController else {
            fatalError("Unable to Instantiate Week View Controller")
        }
        // Configure Week View Controller
            weekViewController.delegate = self
        weekViewController.view.translatesAutoresizingMaskIntoConstraints = false

            return weekViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Child View Controllers
        setupChildViewController()
       
    }
    
    //MARK: - Helper Method
    private func setupChildViewController(){
        
        addChildViewController(dayViewController)
        addChildViewController(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        // Configure Day View
        dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        // Configure Week View
        weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Notify Child View Controller
        dayViewController.didMove(toParentViewController: self)
        weekViewController.didMove(toParentViewController: self)
    }
    
    private func setupViewModel(with viewModel: RootViewModel){
        viewModel.didFetchWeatherData = {[weak self](result)in
            switch result {
            case .success(let weatherData):
                // Initialize Day View Model
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                
                // Update Day View Controller
                self?.dayViewController.viewModel = dayViewModel
                
                // Initialize Week View Model
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                
                // Update Week View Controller
                self?.weekViewController.viewModel = weekViewModel
            case .failure(let error):
                let alertType: AlertType
                
                switch error {
                case .notAuthorizedToRequestLocation:
                    alertType = .notAuthorizedToRequestLocation
                case .failedToRequestLocation:
                    alertType = .failedToRequestLocation
                case .noWeatherDataAvailable:
                    alertType = .noWeatherDataAvailable
            }
                
           self?.presentAlert(of: alertType)
           self?.dayViewController.viewModel = nil
           self?.weekViewController.viewModel = nil
                
            }
        }
    }
    
    private func presentAlert(of alertType : AlertType){
        let title : String
        let message : String
        
        switch alertType {
        case .notAuthorizedToRequestLocation:
            title = "Unable to Fetch weather data for your weather location"
            message = "WeatherWatcher is not authorized to access your current location"
        case .noWeatherDataAvailable:
            title = "Unable to fetch weather data"
            message = "the App is unable to fetch the data. Make sure there's an internet connection"
        case .failedToRequestLocation:
            title = "Unable to fetch weather data for your location"
            message = "WeatherWatcher is having some technical issues"
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAlert)
        present(alertController, animated: true)
    }
}

extension RootViewController: WeekViewControllerDelegate{
    func controllerDidRefresh(_ controller: WeekViewController) {
        viewModel?.refresh()
    }
    
    
}







