//
//  WeekViewController.swift
//  WeatherWatcher
//
//  Created by Rick Williams on 11/1/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate: class {
    func controllerDidRefresh(_ controller: WeekViewController)
}

final class WeekViewController: UIViewController {
    
   weak var delegate: WeekViewControllerDelegate?
    
    var viewModel: WeekViewModel?{
        didSet{
            refreshControl.endRefreshing()
           if  let viewModel = viewModel  {
                setupViewModel(with : viewModel)
            }
            
        }
    }
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.isHidden = true
            tableView.dataSource = self 
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.showsVerticalScrollIndicator = false
            
            tableView.refreshControl = refreshControl
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!{
        
        didSet{
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.Weatherwatch.baseTintColor
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    @objc private func refresh(_ sender:UIRefreshControl){
        delegate?.controllerDidRefresh(self)
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
        
        guard viewModel != nil else {
            fatalError("No View Model available")
        }
        cell.configure(with: viewModel!.viewModel(for: indexPath.row))
        
        return cell
    }
    
    
}
