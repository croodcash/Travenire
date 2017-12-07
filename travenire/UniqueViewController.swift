//
//  UniqueViewController.swift
//  travenire
//
//  Created by Salim Hartono on 11/28/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
import CoreData
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

        // Do any additional setup after loading the view.
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
