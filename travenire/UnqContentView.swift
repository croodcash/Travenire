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
    var curr = 0
    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var imgTitle: UIImageView!
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
        curr += 1
        cell.unqCellImg.image = UIImage(named:"\(String(describing: appDel.code!+1))\(String(curr))")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
