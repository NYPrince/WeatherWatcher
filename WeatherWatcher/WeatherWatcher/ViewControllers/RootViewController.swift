//
//  RootViewController.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/1/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
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
        fetchWeatherData()
        
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
        dayViewController.view.heightAnchor.constraint(equalToConstant: Layout.DayView.height).isActive = true
        
        // Configure Week View
        weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Notify Child View Controller
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    private func fetchWeatherData(){
        guard let baseUrl = URL(string: "https://darksky.net/forecast")else{
            return
        }
        let authenticatedBaseUrl = baseUrl.appendingPathComponent("2523023f1cb6a651fd5ed31fed08244b")
        let url = authenticatedBaseUrl.appendingPathComponent("\(42.3601), \(-71.0589)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request failed")
            }else{
                print(response)
            }
            
        }.resume()
    }

}
extension RootViewController {
    fileprivate enum Layout {
        enum DayView {
             static let height: CGFloat = 200
        }
    }
    
}
















