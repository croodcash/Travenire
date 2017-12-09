//
//  UnqContentView.swift
//  travenire
//
//  Created by Salim Hartono on 12/2/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
import CoreData
class UnqCell: UITableViewCell {
    @IBOutlet weak var unqCellImg: UIImageView!
}
class UnqContentView: UIViewController {
    let appDel = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var imgTitle: UIImageView!
    @IBAction func toStore(_ sender: UIButton) {
        performSegue(withIdentifier: "toStore", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! storeContentView
        des.code = appDel.code! + 1
        var found = false
        for x in 0...appDel.foodStores.count-1{
            if appDel.foodStores[x].code == appDel.code!+1{
                des.index = x
                found = true
            }
        }
        if !found{
            for x in 0...appDel.craftStores.count-1{
                if appDel.craftStores[x].code == appDel.code!+1{
                    des.index = x
                    found = true
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imgTitle.image = UIImage(named: "pic\(String(appDel.code!))")
        
        // Do any additional setup after loading the view.
    }
    
}

extension UnqContentView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDel.cnt!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "explainCell", for: indexPath ) as! UnqCell
        cell.unqCellImg.image = UIImage(named:"\(String(describing: appDel.code!+1))\(String(indexPath.row + 1))")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
