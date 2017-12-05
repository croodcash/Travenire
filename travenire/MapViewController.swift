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

struct store {
    let long: Float64
    let lat: Float64
    let img: String
    let dis: Float64
    let type: String
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
    var stores : [store] = []
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
        var dist = sqrt((Float64(coordinate.latitude) - 6.616058)*(Float64(coordinate.latitude) - 6.616058) + (Float64(coordinate.longitude) - 106.814139)*(Float64(coordinate.longitude) - 106.814139))
        print(dist)
        stores.append(store(long: -6.616058, lat: 106.814139, img: "11", dis: dist , type: "food"))
        
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
        var cnt = 0
        if tableView == storeTableView{
            for s in stores{
                if s.type == "food"{
                    cnt += 1
                }
            }
        }else{
            for s in stores{
                if s.type == "craft"{
                    cnt += 1
                }
            }
        }
        return cnt
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodcell = storeTableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! foodViewCell
        foodcell.foodStoreImg.image  = UIImage(named: "11")
        let craftcell = craftTableView.dequeueReusableCell(withIdentifier: "craft", for: indexPath) as! craftViewCell
        
        if tableView == storeTableView{
            return foodcell
        }else{
            return craftcell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "storeSegue", sender: nil)
        
    }
    
}
