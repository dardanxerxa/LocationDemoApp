//
//  ListTableViewController.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 3.6.21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    let managedContext = FavLocationCoreData.shared.persistentContainer.viewContext
    
    var locationList: [Location]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchLocations()
    }
    
    private func fetchLocations() {
        do {
            self.locationList = try managedContext.fetch(Location.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "location")

        if(cell == nil)
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "location")
        
        }
        
        cell?.textLabel?.text = " \(locationList?[indexPath.row].lat ?? 0.0), \(locationList?[indexPath.row].long ?? 0.0)"
        
        cell?.tag = indexPath.row
        
        if let url = URL(string: locationList?[indexPath.row].image ?? "") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }

                DispatchQueue.main.async() {
                    if cell?.tag == indexPath.row {
                        cell?.imageView?.image = UIImage(data: data)
                        tableView.reloadData()
                    }
                }
            }
            task.resume()
        }
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 60
    }
}

