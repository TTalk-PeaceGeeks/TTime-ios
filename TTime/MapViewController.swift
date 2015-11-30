//
//  MapViewController.swift
//  Estr
//
//  Created by auston salvana on 2015-11-07.
//  Copyright © 2015 ARJHack. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //        if let manager = locationManager {
        //            setupMap()
        //        }
    }
    
    //MARK: CoreLocation delegate methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        let annotation = MKPointAnnotation()
        annotation.title = "BYU Gym"
        annotation.subtitle = "Vancouver, BC, Canada"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 49.2132, longitude: -123.1323)
        
        let annotation2 = MKPointAnnotation()
        annotation2.title = "SFU"
        annotation2.subtitle = "Vancouver, BC, Canada"
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 49.281887, longitude: -123.108188)
        
        let annotation3 = MKPointAnnotation()
        annotation3.title = "Lions gate park"
        annotation3.subtitle = "Vancouver, BC, Canada"
        annotation3.coordinate = CLLocationCoordinate2D(latitude: 49.21111, longitude: -123.1111)

        mapView.showAnnotations([annotation, annotation2, annotation3], animated: true)
        print("update location")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch (status) {
            
        case .NotDetermined:
            print("User still thinking..")
        case .Denied:
            print("User hates you")
        case .AuthorizedWhenInUse:
            print("authorize while in use")
            
        case .AuthorizedAlways:
            locationManager.startUpdatingLocation()
            print("start updatiing")
        default:
            print("\(status)")
            
        }
        
    }
    
    //MARK: helper methods
    
    func setupMap() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 500
        
        locationManager.startUpdatingLocation()
        print("called startUpdating!")
    }
    
}