//
//  WallPostTableView2.swift
//  VoteSelect
//
//  Created by BEN on 17/1/2016.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//


import UIKit
import Parse

class WallView2: PFQueryTableViewController, UITextFieldDelegate{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //1每次顯示照片牆界面，我們都希望它被重新載入
        loadObjects()
    }
    
    //2為了指定運行的請求，我們重寫queryForTable()方法為WallPost返回一個query對象。
    override func queryForTable() -> PFQuery {
        let query = WallPost.query()
        return query!
    }
    
    //3
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        //4從table view中dequeue出一個cell對象，轉換成WallPostTableViewCell類型。
        let cell = tableView.dequeueReusableCellWithIdentifier("WallPostCell", forIndexPath: indexPath) as! WallPostTableViewCell
        
        //5轉換PFObject對象為WallPost類型。
        let wallPost = object as! WallPost
        
        //6調用PFImageView的loadInBackground方法，下載圖片。在complete closure中記錄下載進度。這裡你需要將這個進度顯示在UIProgressBar上。
        cell.postImage.file = wallPost.image
        cell.postImage.loadInBackground(nil) { percent in
            cell.progressView.progress = Float(percent)*0.01
            print("\(percent)%")
        }
        
        //7添加創建日期、用戶名和備註到cell上。
        let creationDate = wallPost.createdAt
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm dd/MM yyyy"
        let dateString = dateFormatter.stringFromDate(creationDate!)
        
        if let username = wallPost.user.username {
            cell.createdByLabel.text = "Uploaded by: \(username), \(dateString)"
        } else {
            cell.createdByLabel.text = "Uploaded by anonymous: , \(dateString)"
        }
        
        cell.commentLabel.text = wallPost.comment
        
        return cell
    }
    
    
    
    
    
    
}
