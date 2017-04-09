//
//  UIViewController.swift
//  VoteSelect
//
//  Created by BEN on 15/1/2016.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorView(error: NSError) {
        if let errorMessage = error.userInfo["error"] as? String {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}