//
//  UniqueViewController.swift
//  travenire
//
//  Created by Salim Hartono on 11/28/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
struct Unique {
    var title: String
    var content: String
    var img: String
    static func fetchData()-> [Unique]{
        var unique: [Unique] = []
        unique.append(Unique(title: "Talas Bogor", content: "kue lapis", img: "indo"))
        return unique
    }
}

class UniqueViewController: UIViewController {
    @IBOutlet weak var tabelViewFood: UITableView!
    
    @IBOutlet weak var tableViewCraft: UITableView!
    
    @IBAction func segChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            tabelViewFood.isHidden = false
            tableViewCraft.isHidden = true
        }else{
            tabelViewFood.isHidden = true
            tableViewCraft.isHidden = false
        }
    }
   
    var data: [Unique] = Unique.fetchData()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelViewFood.isHidden = false
        tableViewCraft.isHidden = true
        // Do any additional setup after loading the view.
    }
}

extension UniqueViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let foodCell = tabelViewFood.dequeueReusableCell(withIdentifier: "foodCell", for : indexPath)
        let craftCell = tableViewCraft.dequeueReusableCell(withIdentifier: "craftCell", for : indexPath)
        foodCell.textLabel?.text = data[indexPath.row].title
        foodCell.detailTextLabel?.text = data[indexPath.row].content
        if tableView == tabelViewFood{
            return foodCell
        }else{
            return craftCell
        }
    }
}
