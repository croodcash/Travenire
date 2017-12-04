//
//  HomeViewController.swift
//  travenire
//
//  Created by Salim Hartono on 11/28/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var storeTableView: UITableView!
    var locationManager = CLLocationManager()
    var loadingIndicator: LoadingIndicator!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator = LoadingIndicator(usedView: self.view)
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            //find location
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startMonitoringSignificantLocationChanges()
        }
        self.mapView.showsUserLocation = true
        var coordinate = CLLocationCoordinate2D()
        coordinate.latitude = (locationManager.location?.coordinate.latitude)!
        coordinate.longitude = (locationManager.location?.coordinate.longitude)!
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.mapView.setRegion(region, animated: true)
        
        let latitude = -6.616058 as CLLocationDegrees
        let longitude = 106.814139 as CLLocationDegrees
        
        //create new annotation
        let newAnotation = MKPointAnnotation()
        newAnotation.title = "Lapis Bogor Sangkuriang"
        newAnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.addAnnotation(newAnotation)
        
        // Do any additional setup after loading the view.
    }

   
}
