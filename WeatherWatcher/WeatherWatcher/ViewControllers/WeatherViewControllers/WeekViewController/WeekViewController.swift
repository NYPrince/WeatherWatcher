//
//  WeekViewController.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/1/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import UIKit

final class WeekViewController: UIViewController {
    
    var viewModel: WeekViewModel?{
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with : viewModel)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
       
    }

    //MARK: - Helper Methods
    func setupView(){
        view.backgroundColor = .red
        
    }
    private func setupViewModel(with viewModel: WeekViewModel){
        print(viewModel)
    }
    
}
