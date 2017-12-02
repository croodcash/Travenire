//
//  ViewController.swift
//  travenire
//
//  Created by Salim Hartono on 11/28/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit
import UserNotifications
class mainViewController: UIViewController {
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    @objc func loadSplashScreen(){
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    /* CODE FOR LOADING SCREEN */
        DispatchQueue.global().async {
            for index in 0...3 {
                DispatchQueue.main.async {
                    self.loadingSpinner.startAnimating()
                }
                sleep(1)
            }
        }
        
    perform(#selector(self.loadSplashScreen), with: nil, afterDelay: 3)
    /* FINISHED LOADING SCREEN */
        
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (didAllow, error) in
        }
        let content = UNMutableNotificationContent()
        content.title = "Travenire"
        content.subtitle = "Welcome to Bogor"
        content.body = "here are special souvenir for you"
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        let request = UNNotificationRequest(identifier: "lala", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    


}

