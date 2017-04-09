//
//  PostInfoViewController.swift
//  VoteSelect
//
//  Created by Socrates Hung on 2016/1/19.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//

import UIKit

class PostInfoViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    //image data
    var imageView = UIImageView()
    //point position
    var yellowPoint = UIButton()
    var greenPoint = UIButton()
    var redPoint = UIButton()
    var bluePoint = UIButton()
    
    

    //post infomation
    var descriptionLabel = UILabel()
    var describingTextView = UITextView()
    var dateLabel = UILabel()
    var datePicker = UIDatePicker()
    
    
    //data from segue
    var numberOfButton : CGFloat? = nil
    var receivedImage : UIImage? = nil
    var greenButtonSite : PointRelativePosition? = PointRelativePosition()
    var redButtonSite : PointRelativePosition? = PointRelativePosition()
    var yellowButtonSite : PointRelativePosition? = PointRelativePosition()
    var blueButtonSite : PointRelativePosition? = PointRelativePosition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Post info view controller : \(__FUNCTION__)")
        
        
        //imageView2.frame = CGRectOffset(imageView1.frame, 0, imageView1.frame.size.height)
        
        //文字敘述
        self.descriptionLabel.text = "文字敘述"
        self.describingTextView.backgroundColor = UIColor.grayColor()
        self.descriptionLabel.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 375, height: 20))
        self.describingTextView.frame = CGRect(origin: CGPoint(x: 0, y: 25), size: CGSize(width: 375, height: 200))
        
        //時間設定
        self.dateLabel.text = "結束時間"
        self.datePicker.timeZone = NSTimeZone.localTimeZone()
        self.dateLabel.frame = CGRect(origin: CGPoint(x: 0, y: 230), size: CGSize(width: 375, height: 20))
        self.datePicker.frame = CGRect(origin: CGPoint(x: 0, y: 255), size: CGSize(width: 375, height: 200))
        
        //影像框架
        self.imageView.image = self.receivedImage
        self.imageView.contentMode = .ScaleAspectFit
        self.imageView.frame = CGRect(origin: CGPoint(x: 0, y: 460), size: CGSize(width: 375, height: 410))
        
        
        
        //點的計算
        //self.greenPoint.frame = CGRect(origin: CGPoint(x: 0, y: 600), size: CGSize(width: 20, height: 20))
        
        
        //設定scroll view 大小
//        var totalHeight : CGFloat = 0
//        var objArr = [self.descriptionLabel, self.describingTextView, self.dateLabel, self.datePicker, self.imageView]
//        for obj in objArr {
//            totalHeight += obj.bounds.height
//            print(obj.frame)
//        }
        
        var size = CGSizeMake(self.view.bounds.width, 870)
        self.scrollView.contentSize = size
        
        //加入物件至scroll view
        self.scrollView.addSubview(self.descriptionLabel)
        self.scrollView.addSubview(self.describingTextView)
        self.scrollView.addSubview(self.dateLabel)
        self.scrollView.addSubview(self.datePicker)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.greenPoint)
        self.scrollView.addSubview(self.redPoint)
        self.scrollView.addSubview(self.yellowPoint)
        self.scrollView.addSubview(self.bluePoint)
        
        //self.view.addSubview(self.scrollView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        var pointArr = [self.yellowPoint, self.greenPoint, self.redPoint, self.bluePoint]
        for var i in 0..<pointArr.count {
            //將所有按鈕變為點的大小
            pointArr[i].bounds.size = CGSize(width: 20, height: 20)
            pointArr[i].layer.cornerRadius = 10
            pointArr[i].layer.borderWidth = 3
            pointArr[i].layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
            
            //改變所有點的透明度
            pointArr[i].alpha = 0
        }
        
        switch self.numberOfButton! {
        case 2 ://two points
            
            //設定定位點
            if self.greenButtonSite != nil {
                self.greenPoint.center = CGPoint(x: self.imageView.center.x + ((self.greenButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.greenButtonSite?.y)! * self.imageView.bounds.height))
                self.greenPoint.alpha = 1
            }
            
            if self.redButtonSite != nil {
                self.redPoint.center = CGPoint(x: self.imageView.center.x + ((self.redButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.redButtonSite?.y)! * self.imageView.bounds.height))
                self.redPoint.alpha = 1
            }
            
        case 3 : //three points
            
            //設定定位點
            if self.greenButtonSite != nil {
                self.greenPoint.center = CGPoint(x: self.imageView.center.x + ((self.greenButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.greenButtonSite?.y)! * self.imageView.bounds.height))
                self.greenPoint.alpha = 1
            }
            
            if self.redButtonSite != nil {
                self.redPoint.center = CGPoint(x: self.imageView.center.x + ((self.redButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.redButtonSite?.y)! * self.imageView.bounds.height))
                self.redPoint.alpha = 1
            }
            
            if self.yellowButtonSite != nil {
                self.yellowPoint.center = CGPoint(x: self.imageView.center.x + ((self.yellowButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.yellowButtonSite?.y)! * self.imageView.bounds.height))
                self.yellowPoint.alpha = 1
            }
        case 4 : //four points
            
            //設定定位點
            if self.greenButtonSite != nil {
                self.greenPoint.center = CGPoint(x: self.imageView.center.x + ((self.greenButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.greenButtonSite?.y)! * self.imageView.bounds.height))
                self.greenPoint.alpha = 1
            }
            
            if self.redButtonSite != nil {
                self.redPoint.center = CGPoint(x: self.imageView.center.x + ((self.redButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.redButtonSite?.y)! * self.imageView.bounds.height))
                self.redPoint.alpha = 1
            }
            
            if self.yellowButtonSite != nil {
                self.yellowPoint.center = CGPoint(x: self.imageView.center.x + ((self.yellowButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.yellowButtonSite?.y)! * self.imageView.bounds.height))
                self.yellowPoint.alpha = 1
            }
            
            if self.blueButtonSite != nil {
                    self.bluePoint.center = CGPoint(x: self.imageView.center.x + ((self.blueButtonSite?.x)! * self.imageView.bounds.width), y: self.imageView.center.y + ((self.blueButtonSite?.y)! * self.imageView.bounds.height))
                    self.bluePoint.alpha = 1
            }
        default : print("something wrong")
        }
        
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    var numtest : Double = 0
    @IBAction func doPost(sender: AnyObject) {
        //文字敘述
        let text = describingTextView.text
        //日期為格林威治時間，需再調整時區設定
        let date = datePicker.date
        
        
        
        print("Post button has been touched")
        print("Text : \(text)")
        print("Date : \(date)")
        
        print("green \(greenButtonSite)")
        print("red \(redButtonSite)")
        print("yellow \(yellowButtonSite)")
        print("blue \(blueButtonSite)")
        
        numtest = Double(greenButtonSite!.x)
        print(numtest)
        
        //        commentTextField.resignFirstResponder()
        
        //Disable the send button until we are ready
        navigationItem.rightBarButtonItem?.enabled = false
        
        //        loadingSpinner.startAnimating()
        
        //TODO: Upload a new picture
        //取得影像資料並設定儲存的壓縮比
        let pictureData = UIImageJPEGRepresentation(self.imageView.image!, 0.8)
        //取得影像資料並設定儲存的壓縮比,壓縮影像資料為JEPG
//        var compressedJPGImage = UIImage(data: imageData!)
        
        
        //1使用image data創建PFFile對象，然後在後台執行保存動作。
        let file = PFFile(name: "image", data: pictureData!)
        file!.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
            if succeeded {
                //2如果成功，保存文件相關PostWall對象。
                self.saveWallPost(file!)
            } else if let error = error {
                //3如果不成功，告知用戶。
                self.showErrorView(error)
            }
            }, progressBlock: { percent in
                //4保存文件時，Parse支持跟蹤保存進度。通過progress block即可得知當前進度。這裡我們只是簡單的把進度列印到控制台。
                print("Uploaded: \(percent)%")
        })
    
    }
    
    func saveWallPost(file: PFFile){
        //1根據上傳圖片、當前已登錄用戶和圖片備註創建WallPost對象。
        let wallPost = WallPost(image: file, user: PFUser.currentUser()!, comment: self.describingTextView.text, numOfButton: Double(numberOfButton!), greenX: numtest, greenY: Double(greenButtonSite!.y), redX: Double(redButtonSite!.x), redY: Double(redButtonSite!.y), yellowX: Double(yellowButtonSite!.x), yellowY: Double(yellowButtonSite!.y), blueX: Double(blueButtonSite!.x), blueY: Double(blueButtonSite!.y), endAt: datePicker.date)
        //2後台保存WallPost對象。
        wallPost.saveInBackgroundWithBlock{ succeeded, error in
            if succeeded {
                //3如果成功，返回照片牆。
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                //4否則，告知用戶。
                if let errorMessage = error?.userInfo["error"] as? String {
                    //              self.showErrorView(error!)
                }
            }
        }
    }
    
}
