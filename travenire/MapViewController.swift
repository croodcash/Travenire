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
    var coordinate: CLLocationCoordinate2D!
    @IBAction func segChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            storeTableView.isHidden = false
            craftTableView.isHidden = true
            foodAnotations()
        }else{
            storeTableView.isHidden = true
            craftTableView.isHidden = false
            craftAnotations()
        }
    }
    
    var index:Int?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location()
        self.mapView.showsUserLocation = true
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.mapView.setRegion(region, animated: true)
        craftAnotations()
        foodAnotations()
        
        // Do any additional setup after loading the view.
    }
    func location() {
        loadingIndicator = LoadingIndicator(usedView: self.view)
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            //find location
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startMonitoringSignificantLocationChanges()
        }
        coordinate = CLLocationCoordinate2D()
        coordinate.latitude = (locationManager.location?.coordinate.latitude)!
        coordinate.longitude = (locationManager.location?.coordinate.longitude)!
    }
    func foodAnotations() {
        let anotations = self.mapView.annotations
        self.mapView.removeAnnotations(anotations)
        appDelegate.foodStores.removeAll()
        var dist = sqrt((Float64(coordinate.latitude) - (-6.616058))*(Float64(coordinate.latitude) - (-6.616058)) + (Float64(coordinate.longitude) - 106.814139)*(Float64(coordinate.longitude) - 106.814139))
        print(dist)
        appDelegate.foodStores.append(AppDelegate.store(long: 106.814139, lat: -6.616058, img: "store1", dis: dist, name:"Lapis Bogor Sangkuriang", code: 1))
        dist = sqrt((Float64(coordinate.latitude) - (-6.611012))*(Float64(coordinate.latitude) - (-6.611012)) + (Float64(coordinate.longitude) - 106.805917)*(Float64(coordinate.longitude) - 106.805917))
        appDelegate.foodStores.append(AppDelegate.store(long: 106.805917, lat: -6.611012, img: "store2", dis: dist, name: "Roti Unyil Venus", code: 2 ))
        dist = sqrt((Float64(coordinate.latitude) - (-6.617491))*(Float64(coordinate.latitude) - (-6.617491)) + (Float64(coordinate.longitude) - 106.811896)*(Float64(coordinate.longitude) - 106.811896))
        appDelegate.foodStores.append(AppDelegate.store(long: 106.811896, lat: -6.617491, img: "store3", dis: dist, name: "Asinan gedung dalem", code: 3))
        appDelegate.foodStores.sort { (store1, store2) -> Bool in
            return store1.dis < store2.dis
        }
        var Anotations : [MKPointAnnotation] = []
        //create new annotation
        var i = 0
        for x in appDelegate.foodStores{
            Anotations.append(MKPointAnnotation())
            Anotations[i].title = x.name
            Anotations[i].coordinate = CLLocationCoordinate2DMake(x.lat as CLLocationDegrees, x.long as CLLocationDegrees)
            i += 1
        }
        self.mapView.addAnnotations(Anotations)
    }
    func craftAnotations() {
        let anotations = self.mapView.annotations
        self.mapView.removeAnnotations(anotations)
        appDelegate.craftStores.removeAll()
        var dist = sqrt((Float64(coordinate.latitude) - (-6.573157))*(Float64(coordinate.latitude) - (-6.573157)) + (Float64(coordinate.longitude) - 106.799530)*(Float64(coordinate.longitude) - 106.799530))
        print(dist)
        appDelegate.craftStores.append(AppDelegate.store(long: 106.799530, lat: -6.573157, img: "store4", dis: dist, name:"Batik Tulis Tradisiku", code: 4))
        dist = sqrt((Float64(coordinate.latitude) - (-6.548280))*(Float64(coordinate.latitude) - (-6.548280)) + (Float64(coordinate.longitude) - 106.775469)*(Float64(coordinate.longitude) - 106.775469))
        appDelegate.craftStores.append(AppDelegate.store(long: 106.775469, lat: -6.548280, img: "store5", dis: dist, name: "Gift Shop Wayang Bambu", code: 5))
        dist = sqrt((Float64(coordinate.latitude) - (-6.624568))*(Float64(coordinate.latitude) - (-6.624568)) + (Float64(coordinate.longitude) - 106.827945)*(Float64(coordinate.longitude) - 106.827945))
        appDelegate.craftStores.append(AppDelegate.store(long: 106.827945, lat: -6.624568, img: "store6", dis: dist, name: "Kujang Padjajaran", code: 6))
        appDelegate.craftStores.sort { (store1, store2) -> Bool in
            return store1.dis < store2.dis
        }
        
        var Anotations : [MKPointAnnotation] = []
        //create new annotation
        var i = 0
        for x in appDelegate.craftStores{
            Anotations.append(MKPointAnnotation())
            Anotations[i].title = x.name
            Anotations[i].coordinate = CLLocationCoordinate2DMake(x.lat as CLLocationDegrees, x.long as CLLocationDegrees)
            i += 1
        }
        self.mapView.addAnnotations(Anotations)
    }
}

extension MapViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == storeTableView{
            return appDelegate.foodStores.count
        }else{
            return appDelegate.craftStores.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodcell = storeTableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! foodViewCell
        let craftcell = craftTableView.dequeueReusableCell(withIdentifier: "craft", for: indexPath) as! craftViewCell
        
        if tableView == storeTableView{
            foodcell.foodStoreImg.image = UIImage(named: appDelegate.foodStores[indexPath.row].img)
            return foodcell
        }else{
            craftcell.craftStoreImg.image = UIImage(named: appDelegate.craftStores[indexPath.row].img)
            return craftcell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! storeContentView
        des.index = index!
        if storeTableView.isHidden == false{
            des.code = appDelegate.foodStores[index!].code
            
        }else{
            des.code = appDelegate.craftStores[index!].code
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "storeSegue", sender: nil)
        
    }
    
}
