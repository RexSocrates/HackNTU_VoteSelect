//
//  SettingTableViewController.swift
//  VoteSelect
//
//  Created by BEN on 22/1/2016.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//

import UIKit
import Parse

class SettingTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = pUserName
            
        }
        
        if let pUserEmail = PFUser.currentUser()?["email"] as? String {
            self.userEmailLabel.text = pUserEmail
        }
        
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        // 傳送使用者登出的要求
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Launch")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
}