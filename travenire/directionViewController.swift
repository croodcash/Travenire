//
//  directionViewController.swift
//  travenire
//
//  Created by Salim Hartono on 12/7/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class directionViewController: UIViewController,MKMapViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var direct: MKMapView!
    var locationManager = CLLocationManager()
    var loadingIndicator: LoadingIndicator!
    var coordinate: CLLocationCoordinate2D!
    var index: Int?
    var code: Int?
    var pickerContent: [String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appDelegate.foodStores.count + appDelegate.craftStores.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerContent[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var found = false
        for x in 0...appDelegate.foodStores.count-1{
            if appDelegate.foodStores[x].name == pickerContent[row]{
                index = x
                code = appDelegate.foodStores[x].code
                found = true
            }
        }
        if !found{
            for x in 0...appDelegate.craftStores.count-1{
                if appDelegate.craftStores[x].name == pickerContent[row]{
                    index = x
                    code = appDelegate.craftStores[x].code
                    found = true
                }
            }
        }
        startRoute()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var idx = index! - 1
        if code!<4{
            for _ in 0...appDelegate.foodStores.count - 1{
                idx += 1
                if idx>2{
                    idx = 0
                }
                pickerContent.append(appDelegate.foodStores[idx].name)
            }
            for x in appDelegate.craftStores{
                pickerContent.append(x.name)
            }
        }else{
            for _ in 0...appDelegate.foodStores.count - 1{
                idx += 1
                if idx>2{
                    idx = 0
                }
                pickerContent.append(appDelegate.craftStores[idx].name)
            }
            for x in appDelegate.foodStores{
                pickerContent.append(x.name)
            }
        }
        loadingIndicator = LoadingIndicator(usedView: self.view)
        self.direct.showsUserLocation = true
        coordinate = CLLocationCoordinate2D()
        coordinate.latitude = (locationManager.location?.coordinate.latitude)!
        coordinate.longitude = (locationManager.location?.coordinate.longitude)!
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.direct.setRegion(region, animated: true)
        startRoute()
        // Do any additional setup after loading the view.
        
    }
    func startRoute() {
        let anotations = self.direct.annotations
        self.direct.removeAnnotations(anotations)
        let overlays = self.direct.overlays
        self.direct.removeOverlays(overlays)
        
        let sourceLocation = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        var destinationLocation: CLLocationCoordinate2D
        if(code!<4){
            destinationLocation = CLLocationCoordinate2D(latitude: appDelegate.foodStores[index!].lat as CLLocationDegrees, longitude: appDelegate.foodStores[index!].long as CLLocationDegrees)
        }else{
            destinationLocation = CLLocationCoordinate2D(latitude: appDelegate.craftStores[index!].lat as CLLocationDegrees, longitude: appDelegate.craftStores[index!].long as CLLocationDegrees)
        }

        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        
        let destinationAnnotation = MKPointAnnotation()
        if code!<4{
            destinationAnnotation.title = appDelegate.foodStores[index!].name
        }else{
            destinationAnnotation.title = appDelegate.craftStores[index!].name
        }
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.direct.showAnnotations([destinationAnnotation], animated: true )
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .any
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.direct.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.direct.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.blue
        render.lineWidth = 5.0
        return render
    }
}
