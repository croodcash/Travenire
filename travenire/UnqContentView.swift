//
//  UnqContentView.swift
//  travenire
//
//  Created by Salim Hartono on 12/2/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit

class UnqContentView: UIViewController {

    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var imgTitle: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgTitle.image = UIImage(named: "lapis")
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
