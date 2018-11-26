//
//  DayViewController.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/1/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {

    //MARK: -Properties
    var viewModel: DayViewModel?{
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            //Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    //MARK: -
    @IBOutlet var datelabel:UILabel!{
        didSet {
            datelabel.textColor = UIColor.Weatherwatch.baseTintColor
            datelabel.font = UIFont.Weatherwatch.heavyLarge
        }
    }
    
    @IBOutlet var timeLabel:UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.Weatherwatch.baseTintColor
        }
    }
 
    
    @IBOutlet var regularLabels: [UILabel]! {
        didSet {
            for label in regularLabels {
                label.textColor = .black
                label.font = UIFont.Weatherwatch.lightRegular
            }
        }
    }
    
    @IBOutlet var smallLabels: [UILabel]! {
        didSet {
            for label in regularLabels {
                label.textColor = .black
                label.font = UIFont.Weatherwatch.lightSmall
            }
        }
    }
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    @IBOutlet var weatherDataViews: [UIView]! {
        didSet {
            for view in weatherDataViews {
                view.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK: - Helper Methods
    
   func setupView(){
    
    view.backgroundColor = .gray
    }
    
    private func setupViewModel(with viewModel: DayViewModel ) {
        activityIndicatorView.stopAnimating()
        
        datelabel.text = viewModel.date
        timeLabel.text = viewModel.time
        windSpeedLabel.text = viewModel.windSpeed
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.summary
        
        iconImageView.image = viewModel.image
        for view in weatherDataViews{
            view.isHidden = false
        }
    }
    
}
