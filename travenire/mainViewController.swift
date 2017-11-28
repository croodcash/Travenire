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

    override func viewDidLoad() {
        super.viewDidLoad()
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

