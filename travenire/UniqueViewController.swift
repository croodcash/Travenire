//
//  UniqueViewController.swift
//  travenire
//
//  Created by Salim Hartono on 11/28/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import UserNotifications

struct Unique {
    var code: Int
    var img: String
    var type: String
    var cnt: Int
}

class foodTableViewCell: UITableViewCell{
    @IBOutlet weak var foodImg: UIImageView!
}
class craftTableViewCell: UITableViewCell{
    @IBOutlet weak var craftImg: UIImageView!
}

class UniqueViewController: UIViewController {
    
    @IBOutlet weak var slider: UIImageView!
    @IBOutlet weak var tabelViewFood: UITableView!
    @IBOutlet weak var tableViewCraft: UITableView!
    @IBAction func segChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            tabelViewFood.isHidden = false
            tableViewCraft.isHidden = true
            super.viewDidLoad()
        }else{
            tabelViewFood.isHidden = true
            tableViewCraft.isHidden = false
            super.viewDidLoad()
        }
    }
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var locationManager = CLLocationManager()
    var loadingIndicator: LoadingIndicator!
    var coordinate: CLLocationCoordinate2D!
    func slide()  {
        DispatchQueue.global().async {
            var i = 1
            while(true){
                if i>4{
                    i = 1
                }
                DispatchQueue.main.async {
                    UIView.commitAnimations()
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDelegate(self)
                    UIView.setAnimationDelay(2.5)
                    UIView.setAnimationCurve(UIViewAnimationCurve.easeIn)
                    self.slider.alpha = CGFloat(1)
                    i += 1
                    self.slider.image = UIImage(named: "promo\(i)")
                    self.slider.alpha = CGFloat(0)
                    
                    UIView.commitAnimations()
                }
                sleep(3)
            }
        }
       
    }
    var data: [Unique] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelViewFood.isHidden = false
        tableViewCraft.isHidden = true
        
        data.append(Unique(code: 1, img: "Food1" , type: "food", cnt: 4))
        data.append(Unique(code: 2, img: "Food2" , type: "food", cnt: 4))
        data.append(Unique(code: 3, img: "Food3" , type: "food", cnt: 4))
        data.append(Unique(code: 1, img: "Craft1" , type: "craft", cnt: 3))
        data.append(Unique(code: 2, img: "Craft2" , type: "craft", cnt: 3))
        data.append(Unique(code: 3, img: "Craft3" , type: "craft", cnt: 4))
        slide()
        add()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (didAllow, error) in
        }
        let content = UNMutableNotificationContent()
        content.title = "Travenire"
        content.subtitle = "Welcome to Bogor"
        content.body = "there is a Souvenire Store nearby you... Check it out!"
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        let request = UNNotificationRequest(identifier: "lala", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        // Do any additional setup after loading the view.
    }
    func add(){
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
        appDelegate.craftStores.removeAll()
        dist = sqrt((Float64(coordinate.latitude) - (-6.573157))*(Float64(coordinate.latitude) - (-6.573157)) + (Float64(coordinate.longitude) - 106.799530)*(Float64(coordinate.longitude) - 106.799530))
        print(dist)
        appDelegate.craftStores.append(AppDelegate.store(long: 106.799530, lat: -6.573157, img: "store4", dis: dist, name:"Batik Tulis Tradisiku", code: 4))
        dist = sqrt((Float64(coordinate.latitude) - (-6.548280))*(Float64(coordinate.latitude) - (-6.548280)) + (Float64(coordinate.longitude) - 106.775469)*(Float64(coordinate.longitude) - 106.775469))
        appDelegate.craftStores.append(AppDelegate.store(long: 106.775469, lat: -6.548280, img: "store5", dis: dist, name: "Gift Shop Wayang Bambu", code: 5))
        dist = sqrt((Float64(coordinate.latitude) - (-6.624568))*(Float64(coordinate.latitude) - (-6.624568)) + (Float64(coordinate.longitude) - 106.827945)*(Float64(coordinate.longitude) - 106.827945))
        appDelegate.craftStores.append(AppDelegate.store(long: 106.827945, lat: -6.624568, img: "store6", dis: dist, name: "Kujang Padjajaran", code: 6))
        appDelegate.craftStores.sort { (store1, store2) -> Bool in
            return store1.dis < store2.dis
        }
    }
    
    
    
}


extension UniqueViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cnt = 0
        if tableView == tableViewCraft {
            for d in data{
                if d.type == "craft"{
                    cnt += 1
                }
            }
            return cnt
        }else{
            for d in data{
                if d.type == "food"{
                    cnt += 1
                 }
            }
            return cnt
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let foodCell = tabelViewFood.dequeueReusableCell(withIdentifier: "foodCell", for : indexPath) as! foodTableViewCell
        let craftCell = tableViewCraft.dequeueReusableCell(withIdentifier: "craftCell", for : indexPath) as! craftTableViewCell
        
        if data[indexPath.row+3].type == "craft"{
            craftCell.craftImg.image = UIImage(named: data[indexPath.row+3].img)
        }
        if data[indexPath.row].type == "food"{
            foodCell.foodImg.image = UIImage(named: data[indexPath.row].img)
        }
        if tableView == tabelViewFood{
            return foodCell
        }else{
            return craftCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueUnique", sender: nil)
        if tabelViewFood.isHidden == false {
            appDelegate.code = indexPath.row
            appDelegate.cnt = data[indexPath.row].cnt
        }else{
            appDelegate.code = indexPath.row+3
            appDelegate.cnt = data[indexPath.row+3].cnt
        }
    }
}
