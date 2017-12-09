//
//  storeContentView.swift
//  travenire
//
//  Created by Salim Hartono on 12/5/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit

struct info {
    let address: String
    let img: String
    let imgProduct: String
    let phone: String
}


class storeContentView: UIViewController {
    var code:Int?
    var index: Int?
    var infos: [info] = []
    
    @IBOutlet weak var storeImg: UIImageView!
    @IBOutlet weak var product: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBAction func call(_ sender: UIButton) {
        if let phoneCallURL = URL(string: "tel://\(infos[code!-1].phone)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    @IBAction func direction(_ sender: UIButton) {
        performSegue(withIdentifier: "direct", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! directionViewController
        des.index = index!
        des.code = code!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        infos.append(info(address: "Jl. Raya Pajajaran No. 20I, Baranangsiang, Bogor Timur, Kota Bogor, Jawa Barat 16143", img: "storePict1", imgProduct: "product1", phone: "02187953909"))
        infos.append(info(address: "Jalan Siliwangi No. 27E, Sukasari, Bogor Timur,Kota Bogor, Jawa Barat 16133", img: "storePict2", imgProduct: "product2", phone: "02518322694"))
        infos.append(info(address: "Jalan Siliwangi No. 27C, Sukasari, Bogor Timur, Kota Bogor, Jawa Barat 16142", img: "storePict3", imgProduct: "product3", phone: "02518313099"))
        infos.append(info(address: "l. Neglasari I Rt.03/04 No.37 Kel. Cibuluh Kec. Bogor Utara", img: "storePict4", imgProduct: "product4", phone: "02518654618"))
        infos.append(info(address: "JL. Raya Baru n12 RT.06/01, Kel. Curug Mekar,Tanah Sereal, Kota Bogor, Jawa Barat 16121", img: "storePict5", imgProduct: "product5", phone: "02518383758"))
        infos.append(info(address: "Jl Parung Banteng Rt.04/01 Kel. Katulampa Kec. Bogor Timur,Kota Bogor, Jawa Barat", img: "storePict6", imgProduct: "product6", phone: "02512270228"))
        address.text = infos[code!-1].address
        storeImg.image = UIImage(named: infos[code!-1].img)
        product.image = UIImage(named: infos[code!-1].imgProduct)
        
        // Do any additional setup after loading the view.
    }

}



