//
//  MapViewController.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 6/2/21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let managedContext = FavLocationCoreData.shared.persistentContainer.viewContext
    
    var locationList: [Location]?
    
    var callback: ((Location, LocationEnum) -> ())?
        
    var tapPressGestureRecognizer: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        tapPressGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapTap(_:)))
        tapPressGestureRecognizer?.delegate = self
        mapView.addGestureRecognizer(tapPressGestureRecognizer!)
        
        fetchLocations()
    }

    override func viewWillAppear(_ animated: Bool) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        if let locations = self.locationList {
            for location in locations {
                addLocationPin(location: location)
            }
        }
    }
    
    func location(location: Location?, locationEnum: LocationEnum?) {
        fetchLocations()
        
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        if let locations = self.locationList {
            print("locations: \(locations)")
            for location in locations {
                addLocationPin(location: location)
            }
        }
    }
    
    private func addLocationPin(location: Location) {
        let favLocation = MKPointAnnotation()
        favLocation.title = location.id.uuidString
        favLocation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
        
        mapView.addAnnotation(favLocation)
    }
    
    private func fetchLocations() {
       
        do {
            self.locationList = try managedContext.fetch(Location.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @objc private func mapTap(_ recognizer: UITapGestureRecognizer?) {
        let point = recognizer?.location(in: mapView)
        let coordinates = mapView?.convert(point ?? CGPoint.zero, toCoordinateFrom: view)
        let location = Location(context: managedContext)
        location.id = UUID()
        location.lat = coordinates?.latitude ?? 0.0
        location.long = coordinates?.longitude ?? 0.0
        
        callback?(location, .add)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let selectedPin = view.annotation as? MKPointAnnotation else { return }
        
        // Move annotation to the center
        mapView.centerCoordinate = view.annotation?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        
        let selectedLocation = locationList?.first(where: { $0.id.uuidString == selectedPin.title })
        
        if let selectedLocation = selectedLocation {
            callback?(selectedLocation, .edit)
        }
        
        mapView.deselectAnnotation(selectedPin, animated: true)
    }
}
