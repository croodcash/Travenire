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
}

class foodTableViewCell: UITableViewCell{
    @IBOutlet weak var foodImg: UIImageView!
    
}
class craftTableViewCell: UITableViewCell{
    @IBOutlet weak var craftImg: UIImageView!
    
}

class UniqueViewController: UIViewController {
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
    
    
    var data: [Unique] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelViewFood.isHidden = false
        tableViewCraft.isHidden = true
        
        let cont = appDelegate.persistentContainer.viewContext
//        let unique = NSEntityDescription.entity(forEntityName: "Data", in: cont)
//        let newData = NSManagedObject(entity: unique!, insertInto: cont)
//        newData.setValue(4, forKey: "code")
//        newData.setValue("Craft4", forKey: "name")
//        newData.setValue("craft", forKey: "type")
//
//        do {
//            try cont.save()
//        } catch  let error as NSError{
//            print(error)
//        }
        
        
        let dataFetch = NSFetchRequest<NSManagedObject>(entityName: "Data")
        do {
            let unq: [NSManagedObject] = try cont.fetch(dataFetch)
            for u in unq {
                print(u.value(forKey: "name") as! String)
                data.append(Unique(code: u.value(forKey: "code") as! Int, img: u.value(forKey: "name") as! String , type: String(describing: u.value(forKey: "type")!)))
            }
        } catch let error as NSError {
            print(error)
        }
        
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
                    print(cnt)
                }
            }
            return cnt
        }else{
            for d in data{
                if d.type == "food"{
                    cnt += 1
                    print(cnt)
                }
            }
            return cnt
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let foodCell = tabelViewFood.dequeueReusableCell(withIdentifier: "foodCell", for : indexPath) as! foodTableViewCell
        let craftCell = tableViewCraft.dequeueReusableCell(withIdentifier: "craftCell", for : indexPath) as! craftTableViewCell
        
        if data[indexPath.row+4].type == "craft"{
            craftCell.craftImg.image = UIImage(named: data[indexPath.row+4].img)
            print("aaa")
        }
        if data[indexPath.row].type == "food"{
            foodCell.foodImg.image = UIImage(named: data[indexPath.row].img)
            print("bbb")
        }
        if tableView == tabelViewFood{
            return foodCell
        }else{
            return craftCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueUnique", sender: nil)
    }
}
