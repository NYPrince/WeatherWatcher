//
//  WeekdayTableViewCell.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/30/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import UIKit

class WeekdayTableViewCell: UITableViewCell {

    static var reuseIdentifier: String{
        return String(describing: self)
    }
    
    @IBOutlet var dayLabel: UILabel! {
        didSet {
            dayLabel.textColor = UIColor.Weatherwatch.baseTextColor
            dayLabel.font = UIFont.Weatherwatch.heavyLarge
        }
    }
    
    @IBOutlet var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = .black
            dateLabel.font = UIFont.Weatherwatch.lightRegular
        }
    }
    
    @IBOutlet var windSpeedLabel: UILabel! {
        didSet {
            windSpeedLabel.textColor = .black
            windSpeedLabel.font = UIFont.Weatherwatch.lightSmall
        }
    }
    
    @IBOutlet var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = .black
            temperatureLabel.font = UIFont.Weatherwatch.lightSmall
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.Weatherwatch.baseTintColor
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    func configure(with representable: WeekDayRepresentable){
        dayLabel.text = representable.day
        dateLabel.text = representable.date
        iconImageView.image = representable.image
        windSpeedLabel.text = representable.windSpeed
        temperatureLabel.text = representable.temperature
    }
    
    
    

}
