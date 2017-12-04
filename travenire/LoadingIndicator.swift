//
//  LoadingIndicator.swift
//  travenire
//
//  Created by Salim Hartono on 12/4/17.
//  Copyright © 2017 SYARF. All rights reserved.
//

import UIKit

class LoadingIndicator {
    let view: UIView!
    let activityIndicator: UIActivityIndicatorView!
    
    init(usedView: UIView) {
        view = usedView
        activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
    }
    
    func startLoading() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        UIApplication.shared.endIgnoringInteractionEvents()
        self.activityIndicator.stopAnimating()
    }
}
