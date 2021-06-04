//
//  LocationViewController.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 6/2/21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreLocation
import Firebase

class LocationViewController: UIViewController {
    
    @IBOutlet weak var changeViewButton: UIButton! {
        didSet {
         changeViewButton.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
         changeViewButton.layer.cornerRadius = 10
         changeViewButton.layer.borderWidth = 2
         changeViewButton.layer.borderColor = UIColor.white.cgColor
        }
        
    }
    
    @IBOutlet weak var viewContainer: UIView!
    
    private lazy var mapViewController: MapViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "map") as! MapViewController
        
        viewController.callback = { [weak self] (location, locationEnum) in
            self?.showAddEditLocation(location: location, locationEnum: locationEnum)
        }
        
        return viewController
    }()

    private lazy var listViewController: ListTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "list") as! ListTableViewController

        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(asChildViewController: mapViewController)
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "welcomeNav")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
            
        }  catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
 
    @IBAction func changeViewAction(_ sender: Any) {
       
        if changeViewButton.titleLabel?.text == "List" {
            changeViewButton.setTitle("Map", for: .normal)
            remove(asChildViewController: mapViewController)
            add(asChildViewController: listViewController)
        } else {
            changeViewButton.setTitle("List", for: .normal)
            remove(asChildViewController: listViewController)
            add(asChildViewController: mapViewController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        addChild(viewController)
        viewContainer.addSubview(viewController.view)
        viewController.view.frame = viewContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
       
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func showAddEditLocation(location: Location, locationEnum: LocationEnum) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addEdit") as! AddEditLocationViewController
        
        vc.location = location
        vc.locationEnum = locationEnum
        
        vc.callBack = { [weak self] location, locationEnum in
            if let location = location {
                self?.mapViewController.location(location: location, locationEnum: locationEnum)
            } else {
                
            }
        }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}
