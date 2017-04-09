//
//  ProfileViewController.swift
//  VoteSelect
//
//  Created by BEN on 26/12/2015.
//  Copyright © 2015年 8en7am1n. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var topBackgroundView: UIImageView!
    @IBOutlet weak var navigationItemUserName: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addEddect()//模糊
        
        // Do any additional setup after loading the view, typically from a nib.
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = pUserName
            self.navigationItemUserName.title = pUserName
        }
        
        //顯示用戶頭像
        if let userPicture = PFUser.currentUser()?["profileImage"] as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    self.profileImageView.image = UIImage(data:imageData!)
                    self.topBackgroundView.image = self.profileImageView.image
                }
            }
        }
        
        //profileImageView圓角
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
        profileImageView.layer.borderWidth = 5
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        // 傳送使用者登出的要求
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Launch")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Launch") as! UIViewController
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    
    //模糊
    func addEddect(){
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        
        visualEffectView.frame = topBackgroundView.bounds
        
        topBackgroundView.addSubview(visualEffectView)
    }
    
}
