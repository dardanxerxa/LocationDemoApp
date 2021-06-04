//
//  AddEditLocationViewController.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 3.6.21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import UIKit
import CoreData

enum LocationEnum {
    case add
    case edit
    case delete
}

class AddEditLocationViewController: UIViewController {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UITextField!
    @IBOutlet weak var longtitudeLabel: UITextField!
    @IBOutlet weak var imageUrlLabel: UITextField!
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let managedContext = FavLocationCoreData.shared.persistentContainer.viewContext
    
    var location: Location?
    var locationEnum: LocationEnum = .add
    
    var callBack: ((Location?, LocationEnum?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = locationEnum == .add ? "Add Location" : "Edit Location"
        
        deleteButton.isHidden = locationEnum == .add
        
        guard let location = location else { return }
        
        latitudeLabel.text = String(describing: location.lat)
        longtitudeLabel.text = String(describing: location.long)
        imageUrlLabel.text = location.image
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        cancelLocation()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        addEditLocation()
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        deleteLocation()
    }
    
    private func addEditLocation() {
        location?.lat = Double(latitudeLabel.text ?? "") ?? 0.0
        location?.long = Double(longtitudeLabel.text ?? "") ?? 0.0
        location?.image = imageUrlLabel.text ?? ""
        
        syncCoreData(locationEnum: nil)
    }

    private func deleteLocation() {
        if location != nil {
            managedContext.delete(location!)
            
            syncCoreData(locationEnum: .delete)
        }
    }
    
    private func cancelLocation() {
        if location != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func syncCoreData(locationEnum: LocationEnum?) {
        do {
            try managedContext.save()
            
            callBack?(location, locationEnum)
            
            dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
