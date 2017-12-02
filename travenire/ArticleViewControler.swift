//
//  ArticleViewControler.swift
//  travenire
//
//  Created by Salim Hartono on 11/28/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit

struct Article {
    var img: String
    var site: String
    static func fetchData()-> [Article]{
        var article: [Article] = []
        article.append(Article(img: "Feed1" , site : "index.html"))
        article.append(Article(img: "Feed2", site: "index1.html"))
        article.append(Article(img: "Feed3" , site : "index2.html"))
        article.append(Article(img: "Feed4", site: "index3.html"))
        return article
    }
}

class articleTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
}

class ArticleViewControler: UIViewController{
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var contactUsView: UIView!
    @IBAction func contactUs(_ sender: UIButton) {
        contactUsView.isHidden = false
        self.articleTableView.isUserInteractionEnabled = false
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.articleTableView.isUserInteractionEnabled = true
        contactUsView.isHidden = true
    }
    
    var data: [Article] = Article.fetchData()
    
    @IBOutlet weak var contUs: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactUsView.isHidden = true
        // Do any additional setup after loading the view.
    }
}
var web: [String] = []
var cnt: Int = 0
class ArticleContentViewControler: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let site = ("http://travenire.site11.com/\(web[cnt])")
        let url = URL (string: site)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
    }
}

extension ArticleViewControler: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for : indexPath) as! articleTableViewCell
        cell.img.image = UIImage(named: data[indexPath.row].img)
        web.append(data[indexPath.row].site)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cnt = indexPath.row
        performSegue(withIdentifier: "segue1", sender: nil)

    }
}
