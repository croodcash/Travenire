//
//  UnqContentView.swift
//  travenire
//
//  Created by Salim Hartono on 12/2/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
import CoreData
class UnqContentView: UIViewController {
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var imgTitle: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgTitle.image = UIImage(named: "pic\(String(appDel.code!))")
        
        
        let cont = appDel.persistentContainer.viewContext
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
        
        
        let dataFetch = NSFetchRequest<NSManagedObject>(entityName: "Explain")
        do {
            let unq: [NSManagedObject] = try cont.fetch(dataFetch)
            for u in unq {
                print(u.value(forKey: "code") as! String)
    
            }
        } catch let error as NSError {
            print(error)
        }
        
        // Do any additional setup after loading the view.
    }
    
}

extension UnqContentView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "explainCell", for: indexPath )
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
