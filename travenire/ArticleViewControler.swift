//
//  ArticleViewControler.swift
//  travenire
//
//  Created by Salim Hartono on 11/28/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit

struct Article {
    var title: String
    var content: String
    var img: String
    static func fetchData()-> [Article]{
        var article: [Article] = []
        article.append(Article(title: "gonteng", content: "article", img: "indo"))
        return article
    }
}

class articleTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var img: UIImageView!
    
}

class ArticleViewControler: UIViewController{
    @IBOutlet weak var articleTableView: UITableView!
    var data: [Article] = Article.fetchData()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
class ArticleContentViewControler: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: "http://travel.kompas.com/read/2017/10/28/072200127/5-obyek-wisata-bogor-yang-kekinian")
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
        cell.title.text = data[indexPath.row].title
        cell.content.text = data[indexPath.row].content
        cell.img.image = UIImage(named: data[indexPath.row].img)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0){
            performSegue(withIdentifier: "segue1", sender: nil)
        }
    }
}
