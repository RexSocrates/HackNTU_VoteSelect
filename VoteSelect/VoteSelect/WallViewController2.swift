//
//  HomeViewController.swift
//  VoteSelect
//
//  Created by BEN on 24/12/2015.
//  Copyright © 2015年 8en7am1n. All rights reserved.
//

import UIKit
import Parse

class WallViewController2: PFQueryTableViewController, UITextFieldDelegate{
    
    var numberOfButton : Int = 0
    
    //點的相對位置資訊
    var yellowPointSite : PointRelativePosition? = nil
    var greenPointSite : PointRelativePosition? = nil
    var redPointSite : PointRelativePosition? = nil
    var bluePointSite : PointRelativePosition? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
//        tableView.registerClass(WallPostTableViewCell.self, forCellReuseIdentifier: "WallPostTableViewCell")
        
        for item in (self.tabBarController?.tabBar.items as NSArray!){
            (item as! UITabBarItem).image = (item as! UITabBarItem).image?.imageWithRenderingMode(.AlwaysOriginal)
        }//tab bar item keep Original
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
//    override func viewDidLayoutSubviews() {
//        print(__FUNCTION__)
//        
//        switch self.numberOfButton {
//        case 2 : print("2")
//            
//            
//        default : print("number of button is not 2")
//        }
//    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        //如果沒有登入，彈出至登入畫面
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Launch") as! UIViewController
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
        //
        
        //1每次顯示照片牆界面，我們都希望它被重新載入
        loadObjects()
    }
    
    //2為了指定運行的請求，我們重寫queryForTable()方法為WallPost返回一個query對象。
    override func queryForTable() -> PFQuery {
        let query = WallPost.query()
        return query!
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //
        print("")
        let cell = cell as? WallPostTableViewCell
        cell?.greenButtonVar.translatesAutoresizingMaskIntoConstraints = true
        
        cell!.greenButtonVar.frame.origin.y = 403
        cell!.greenButtonVar.bounds.size = CGSize(width: 375/2, height: 44)
//        cell?.bringSubviewToFront((cell?.greenButtonVar)!)
//        cell!.greenButtonVar.hidden = true
//        cell?.setNeedsDisplay()
//        cell?.setNeedsLayout()
        
//        cell!.setNeedsUpdateConstraints = true
//        cell?.setNeedsUpdateConstraints()
//        cell?.updateConstraintsIfNeeded()
//        cell?.layoutSubviews()
    }
    //3
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        //4從table view中dequeue出一個cell對象，轉換成WallPostTableViewCell類型。
//        var cell = tableView.dequeueReusableCellWithIdentifier("WallPostCell") as? WallPostTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("WallPostCell", forIndexPath: indexPath) as? WallPostTableViewCell
        
        cell!.voteYellow.alpha = 0
        cell!.voteGreen.alpha = 0
        cell!.voteRed.alpha = 0
        cell!.voteBlue.alpha = 0
        
//        if cell==nil
//        {
//            cell=WallPostTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "WallPostCell")
//        }
//        cell?.parseObject = object
        
        
        
        
        //5轉換PFObject對象為WallPost類型。
        let wallPost = object as! WallPost
    
        //6調用PFImageView的loadInBackground方法，下載圖片。在complete closure中記錄下載進度。這裡你需要將這個進度顯示在UIProgressBar上。
        cell!.postImage.file = wallPost.image
        cell!.postImage.loadInBackground(nil) { percent in
            cell!.progressView.progress = Float(percent)*0.01
            print("\(percent)%")
        }
    
        //7添加創建日期、用戶名和備註到cell上。
        let creationDate = wallPost.createdAt
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm dd/MM yyyy"
        let dateString = dateFormatter.stringFromDate(creationDate!)
    
        if let username = wallPost.user.username {
            cell!.createdByLabel.text = "\(username)"
//            cell!.userImageView.image = wallPost.user
            if let userPicture = PFUser.currentUser()?["profileImage"] as? PFFile {
                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        cell!.userImageView.image = UIImage(data:imageData!)
                    }
                }
                //profileImageView圓角
                cell!.userImageView.layer.cornerRadius = cell!.userImageView.frame.size.width / 2
                cell!.userImageView.layer.masksToBounds = true
                cell!.userImageView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                cell!.userImageView.layer.borderWidth = 5
            }
        } else {
            cell!.createdByLabel.text = "Uploaded by anonymous: , \(dateString)"
        }
            
        cell!.commentLabel.text = wallPost.comment
        cell!.timeLabel.text = "\(dateString)"
        
        tableView.allowsSelection = false
        
        
        //依照按鈕數量調整排版，以下為測試用參數
//        var numberOfButton : Int = Int(arc4random_uniform(3) + 2)
        
        
        //隱藏所有的點
        cell!.yellowPointLabel.alpha = 0
        cell!.greenPointLabel.alpha = 0
        cell!.redPointLabel.alpha = 0
        cell!.bluePointLabel.alpha = 0
        
        
        print("number of button : \(wallPost.numOfButton)")
        numberOfButton = Int(wallPost.numOfButton)
        
        cell!.greenButtonVar.bounds.size = CGSize(width: 375/2, height: 44)
//        cell!.greenButtonVar.removeFromSuperview()
        
        switch numberOfButton {
        case 2 : //按鈕數量為二
            print("two buttons")
            //調整透明度
            cell!.yellowButtonVar.alpha = 0
            cell!.greenButtonVar.alpha = 1
            cell!.redButtonVar.alpha = 1
            cell!.blueButtonVar.alpha = 0
            
            //調整按鈕大小
            let buttonSize = ButtonSize(numberOfButton: CGFloat(numberOfButton))
            print("buttonWidth : \(buttonSize.width)")
            
            if self.greenPointSite != nil {
                //設定大小
                cell!.greenButtonVar.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
                //設定位置
                cell!.greenButtonVar.center = CGPoint(x: 7.5 + 0.5 * buttonSize.width, y: 325 + 0.5 + buttonSize.height)
                
                //設定標籤的位置
                cell!.greenPointLabel.alpha = 1
            }
            
            if self.redPointSite != nil {
                //設定大小
                cell!.redButtonVar.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
                
                //設定位置
                cell!.redButtonVar.center = CGPoint(x: 7.5 + 1.5 * buttonSize.width, y: 325 + 0.5 + buttonSize.height)
                
                cell!.redPointLabel.alpha = 1
            }
            
            
            
            
            
        case 3 : print("three buttons")
            
            //調整按鈕透明度
            cell!.yellowButtonVar.alpha = 1
            cell!.greenButtonVar.alpha = 1
            cell!.redButtonVar.alpha = 1
            cell!.blueButtonVar.alpha = 0
            
            //調整按鈕大小
            let buttonSize = ButtonSize(numberOfButton: CGFloat(numberOfButton))
            var buttonArr = [cell!.yellowButtonVar, cell!.greenButtonVar, cell!.redButtonVar]
            print("buttonWidth : \(buttonSize.width)")
            for button in buttonArr {
                button.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
            }
        
        
        
            //調整按鈕位置
            cell!.yellowButtonVar.center = CGPoint(x: 7.5 + 0.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
            cell!.greenButtonVar.center = CGPoint(x: 7.5 + 1.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
            cell!.redButtonVar.center = CGPoint(x: 7.5 + 2.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
            
            if self.greenPointSite != nil {
                //設定大小
                cell!.greenButtonVar.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
                //設定位置
                cell!.greenButtonVar.center = CGPoint(x: 7.5 + 0.5 * buttonSize.width, y: 325 + 0.5 + buttonSize.height)
                
                //設定標籤的位置
                cell!.greenPointLabel.bounds.size = CGSize(width: 20, height: 20)
                cell!.greenPointLabel.layer.cornerRadius = 10
                cell!.greenPointLabel.layer.borderWidth = 3
                cell!.greenPointLabel.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                cell!.greenPointLabel.alpha = 1
            }
        
            if self.redPointSite != nil {
                //設定大小
                cell!.redButtonVar.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
                
                //設定位置
                cell!.redButtonVar.center = CGPoint(x: 7.5 + 1.5 * buttonSize.width, y: 325 + 0.5 + buttonSize.height)
                
                cell!.redPointLabel.bounds.size = CGSize(width: 20, height: 20)
                cell!.redPointLabel.layer.cornerRadius = 10
                cell!.redPointLabel.layer.borderWidth = 3
                cell!.redPointLabel.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                cell!.redPointLabel.alpha = 1
            }
            
            if self.yellowPointSite != nil {
                cell!.yellowPointLabel.bounds.size = CGSize(width: 20, height: 20)
                cell!.yellowPointLabel.layer.cornerRadius = 10
                cell!.yellowPointLabel.layer.borderWidth = 3
                cell!.yellowPointLabel.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                cell!.yellowPointLabel.alpha = 1
            }
            
            
        case 4 : print("four buttons")
        
            //調整按鈕透明度
            cell!.yellowButtonVar.alpha = 1
            cell!.greenButtonVar.alpha = 1
            cell!.redButtonVar.alpha = 1
            cell!.blueButtonVar.alpha = 1
            
            
            //調整按鈕大小
            let buttonSize = ButtonSize(numberOfButton: CGFloat(numberOfButton))
            var buttonArr = [cell!.yellowButtonVar, cell!.greenButtonVar, cell!.redButtonVar, cell!.blueButtonVar]
            print("buttonWidth : \(buttonSize.width)")
            for button in buttonArr {
                button.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
            }
            
            //調整按鈕位置
            cell!.yellowButtonVar.center = CGPoint(x: 7.5 + 0.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
            cell!.greenButtonVar.center = CGPoint(x: 7.5 + 1.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
            cell!.redButtonVar.center = CGPoint(x: 7.5 + 2.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
            cell!.blueButtonVar.center = CGPoint(x: 7.5 + 3.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
            
            
            if self.greenPointSite != nil {
                
                cell!.greenPointLabel.bounds.size = CGSize(width: 20, height: 20)
                cell!.greenPointLabel.layer.cornerRadius = 10
                cell!.greenPointLabel.layer.borderWidth = 3
                cell!.greenPointLabel.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                cell!.greenPointLabel.alpha = 1
            }
            
            if self.redPointSite != nil {
                cell!.redPointLabel.bounds.size = CGSize(width: 20, height: 20)
                cell!.redPointLabel.layer.cornerRadius = 10
                cell!.redPointLabel.layer.borderWidth = 3
                cell!.redPointLabel.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                cell!.redPointLabel.alpha = 1
            }
            
            if self.yellowPointSite != nil {
                cell!.yellowPointLabel.bounds.size = CGSize(width: 20, height: 20)
                cell!.yellowPointLabel.layer.cornerRadius = 10
                cell!.yellowPointLabel.layer.borderWidth = 3
                cell!.yellowPointLabel.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                cell!.yellowPointLabel.alpha = 1
            }
            
            if self.bluePointSite != nil {
                cell!.bluePointLabel.bounds.size = CGSize(width: 20, height: 20)
                cell!.bluePointLabel.layer.cornerRadius = 10
                cell!.bluePointLabel.layer.borderWidth = 3
                cell!.bluePointLabel.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                cell!.bluePointLabel.alpha = 1
            }
            
            
        default : print("number of button is wrong")
            //調整按鈕透明度
            cell!.yellowButtonVar.alpha = 1
            cell!.greenButtonVar.alpha = 1
            cell!.redButtonVar.alpha = 1
            cell!.blueButtonVar.alpha = 1
        
        
            //調整按鈕大小
//            let buttonSize = ButtonSize(numberOfButton: CGFloat(numberOfButton))
//            var buttonArr = [cell!.yellowButtonVar, cell!.greenButtonVar, cell!.redButtonVar, cell!.blueButtonVar]
//            for button in buttonArr {
//                button.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
//            }
        
            //調整按鈕位置
//            cell!.yellowButtonVar.center = CGPoint(x: 7.5 + 0.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
//            cell!.greenButtonVar.center = CGPoint(x: 7.5 + 1.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
//            cell!.redButtonVar.center = CGPoint(x: 7.5 + 2.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
//            cell!.blueButtonVar.center = CGPoint(x: 7.5 + 3.5 * buttonSize.width, y: 325 + 0.5 * buttonSize.height)
        }
        
        return cell
    }
    
    
    
}

//計算按鈕
struct ButtonSize {
    var totalLength : CGFloat = 360
    var width : CGFloat
    var height : CGFloat
    
    init(numberOfButton : CGFloat) {
        self.width = self.totalLength / numberOfButton
        self.height = 44
    }
}
