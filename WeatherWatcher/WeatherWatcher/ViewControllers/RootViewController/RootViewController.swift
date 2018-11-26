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
    
    private let weekViewController: WeekViewController = {
        guard let weekViewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.StoryboardIndentifier) as? WeekViewController else {
            fatalError("Unable to Instantiate Week View Controller")
        }
        // Configure Week View Controller
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
        
        addChild(dayViewController)
        addChild(weekViewController)
        
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
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    private func setupViewModel(with viewModel: RootViewModel){
        viewModel.didFetchWeatherData = {[weak self](weatherData, error)in
            if let _ = error {
                self?.presentAlert(of: .noWeatherDataAvailable)
            }else if let weatherData = weatherData as? DarkSkyResponse {
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                 self?.dayViewController.viewModel = dayViewModel 
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                self?.weekViewController.viewModel = weekViewModel
            }else{
                self?.presentAlert(of: .noWeatherDataAvailable)
            }
        }
    }
    
    private func presentAlert(of alertType : AlertType){
        let title : String
        let message : String
        
        switch alertType {
        case .noWeatherDataAvailable:
            title = "Unable to fetch weather data"
            message = "the App is unable to fetch the data. Make sure there's an internet connection"
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAlert)
        present(alertController, animated: true)
    }
}

















