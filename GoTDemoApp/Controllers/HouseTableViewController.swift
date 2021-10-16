//
//  HouseTableViewController.swift
//  GoTDemoApp
//
//  Created by Coding on 10/14/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import UIKit

class HouseTableViewController: UITableViewController {
    
    //MARK: - properties
    
    private var houses: [House] = []
    private var activitySpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .systemYellow
        spinner.style = .large
        return spinner
    }()
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activitySpinner)
        title = "G.O.T. Houses"
        
        configureCells()
        fetchHouses()
        
        print(houses.count)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activitySpinner.setDimensions(height: 70, width: 70)
        activitySpinner.center(inView: view)
    }
    
    //MARK: - actions
    
    //MARK: - helpers
    
    private func fetchHouses(){
        
        activitySpinner.startAnimating()
        
        APICaller.shared.fetchHouses { result in
            
            switch result {
            case .success(let response):
                
                DispatchQueue.main.async {
                    self.activitySpinner.stopAnimating()
                }
                self.houses = response
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                break
            }
            
        }
        
    }
    
    private func configureCells(){
        
        tableView.register(GOTHouseTableViewCell.self, forCellReuseIdentifier: GOTHouseTableViewCell.identifier)
        
    }
    
    private func goToHouse(_ house: House){
        
        let vc = HouseDetailViewController(house)
        vc.title = house.name.replacingOccurrences(of: "House ", with: "")
        
        show(vc, sender: self)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GOTHouseTableViewCell.identifier, for: indexPath) as! GOTHouseTableViewCell
        
        let house = houses[indexPath.row]
        cell.viewModel = HouseViewModel(house: house)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        goToHouse(houses[indexPath.row])
    }
}
