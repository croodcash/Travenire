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

class foodViewCell: UITableViewCell{
  
    @IBOutlet weak var foodStoreImg: UIImageView!
    
}
class craftViewCell: UITableViewCell{
  
    @IBOutlet weak var craftStoreImg: UIImageView!
    
}
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var storeTableView: UITableView!
    @IBOutlet weak var craftTableView: UITableView!
    var locationManager = CLLocationManager()
    var loadingIndicator: LoadingIndicator!
    @IBAction func segChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            storeTableView.isHidden = false
            craftTableView.isHidden = true
        }else{
            
            storeTableView.isHidden = true
            craftTableView.isHidden = false
        }
    }
    
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

extension MapViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storeTableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! foodViewCell
        cell.foodStoreImg.image  = UIImage(named: "11")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "storeSegue", sender: nil)
        
    }
    
}
