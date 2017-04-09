//
//  HomeViewController.swift
//  VoteSelect
//
//  Created by BEN on 24/12/2015.
//  Copyright © 2015年 8en7am1n. All rights reserved.
//

import UIKit
import Parse

class HomeViewControllerScroll: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var wallScroll: UIScrollView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for item in (self.tabBarController?.tabBar.items as NSArray!){
            (item as! UITabBarItem).image = (item as! UITabBarItem).image?.imageWithRenderingMode(.AlwaysOriginal)
        }//tab bar item keep Original
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    override func viewWillAppear(animated: Bool) {
        //如果沒有登入，彈出至登入畫面
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Launch") as! UIViewController
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
        //
        
        //Clean the scroll view
        cleanWall()
        
        //Reload the wall
        getWallImages()
    }
    
    func cleanWall() {
        for viewToRemove in wallScroll.subviews {
            if let viewToRemove = viewToRemove as? UIView {
                viewToRemove.removeFromSuperview()
            }
        }
    }
    
    func loadWallViews(objects: [WallPost]) {
        //Clean the scroll view
        cleanWall()
        
        var originY: CGFloat = 0
        for wallPost: WallPost in objects {

            //1創建一個視圖來顯示圖片和詳情。
            let wallView = UIView(frame: CGRect(x: 0, y: originY, width: self.wallScroll.frame.size.width, height: 270))
            
            //2下載圖片數據。
            wallPost.image.getDataInBackgroundWithBlock { data, error in
                if let data = data {
                    if let image = UIImage(data: data) {
                        
                        //3添加圖片視圖到照片牆。
                        //Add the image
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: 10, y: 10, width: wallView.frame.size.width - 20, height: 200)
                        imageView.contentMode = UIViewContentMode.ScaleAspectFit
                        wallView.addSubview(imageView)
                        
                        //4獲取上傳圖片的用戶的信息，將創建日期放置在label上。
                        //Add the info label (User and creation date)
                        let creationDate = wallPost.createdAt
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "HH:mm dd/MM yyyy"
                        
                        let infoLabel = UILabel(frame: CGRect(x: 10, y: 220, width: 0, height: 0))
                        let dateString = dateFormatter.stringFromDate(creationDate!)
                        
                        if let username = wallPost.user.username {
                            infoLabel.text = "Uploaded by: \(username), \(dateString)"
                        } else {
                            infoLabel.text = "Uploaded by anonymous: , \(dateString)"
                        }
                        
                        infoLabel.text = "Uploaded by: \(wallPost.user.username), \(dateString)"
                        infoLabel.font = UIFont(name: "HelveticaNeue", size: 12)
                        infoLabel.textColor = UIColor.whiteColor()
                        infoLabel.backgroundColor = UIColor.clearColor()
                        infoLabel.sizeToFit()
                        wallView.addSubview(infoLabel)
                        
                        //5添加包含備註信息的label。
                        //Add the comment label (User and creation date)
                        let commentLabel = UILabel(frame: CGRect(x: 10, y: CGRectGetMaxY(infoLabel.frame)+5, width:0, height: 0))
                        commentLabel.text = wallPost.comment
                        commentLabel.font = UIFont(name: "HelveticaNeue", size: 16)
                        commentLabel.textColor = UIColor.whiteColor()
                        commentLabel.backgroundColor = UIColor.clearColor()
                        commentLabel.sizeToFit()
                        wallView.addSubview(commentLabel)
                    }
                }
            }
            
            //6將上述界面元素放置到scroll view上，並且增加用以指示下個顯示位置的坐標。
            self.wallScroll.addSubview(wallView)
            originY += 270
        }
        //7設置scrollview的content size。
        self.wallScroll.contentSize.height = CGFloat(originY)
    }
    
    func getWallImages() {
        //1創建一個簡單的query 對象來獲取WallPost對象，並將結果按照創建日期排序。
        let query = WallPost.query()!
        query.findObjectsInBackgroundWithBlock { objects, error in
            if error == nil {
                //2查找到符合條件的對象。這裡，即為WallPost對象。如果一切正常，則在照片牆上載入圖片。
                if let objects = objects as? [WallPost] {
                    self.loadWallViews(objects)
                }
            } else if let error = error {
                //3如果有錯誤的話，提示用戶。
                self.showErrorView(error)
            }
        }
    }
    
}
