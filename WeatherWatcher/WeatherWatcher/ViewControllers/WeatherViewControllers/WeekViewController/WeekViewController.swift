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
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.isHidden = true
            tableView.dataSource = self as! UITableViewDataSource
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.showsVerticalScrollIndicator = false
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!{
        
        didSet{
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
       
    }

    //MARK: - Helper Methods
    func setupView(){
        view.backgroundColor = .white
        
    }
    private func setupViewModel(with viewModel: WeekViewModel){
        print(viewModel)
        
        tableView.reloadData()
        tableView.isHidden = false
    }
    
}
extension WeekViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekdayTableViewCell.reuseIdentifier, for: indexPath)as? WeekdayTableViewCell else {
            fatalError("Unable to fetch Week day View cell")
        }
        
        guard let veiwModel = viewModel else {
            fatalError("No View Model available")
        }
        cell.configure(with: viewModel!.viewModel(for: indexPath.row))
        
        return cell
    }
    
    
}
