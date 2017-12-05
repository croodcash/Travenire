//
//  storeContentView.swift
//  travenire
//
//  Created by Salim Hartono on 12/5/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
class productCell: UITableViewCell{
    
    @IBOutlet weak var foodImg: UIImageView!
}

class storeContentView: UIViewController {

    @IBOutlet weak var productTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}

extension storeContentView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! productCell
        cell.foodImg.image = UIImage(named: "11")
        return cell
    }
}

