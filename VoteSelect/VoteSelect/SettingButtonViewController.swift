//
//  SettingButtonViewController.swift
//  VoteSelect
//
//  Created by Socrates Hung on 2016/1/19.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//

import UIKit

class SettingButtonViewController: UIViewController {
    
    // MARK: - Property
    var toNextPage : Bool = false
    
    //button size data
    var numberOfButton : CGFloat = 2
    let originalButtonHeight : CGFloat = 44
    
    //data from segue
    var receivedImage : UIImageView?
    @IBOutlet weak var image: UIImageView!
    
    //function button
    @IBOutlet weak var addButtonVar: UIButton!
    @IBOutlet weak var resetButtonVar: UIButton!
    @IBOutlet weak var deleteButtonVar: UIButton!
    
    
    
    //color button
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    //if button has been moved
    var greenMoved = false
    var redMoved = false
    var yellowMoved = false
    var blueMoved = false
    
    
    // MARK: - View function
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
    }
    
    //會三不五時被觸發
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Add button : \(__FUNCTION__)")
        print("Add button - to next page : \(self.toNextPage))")
        
        
        //如果已經到過下一頁就不需再次初始化
        if self.toNextPage {
            //已經去過下一頁
            print("已經去過下一頁(三不五時被呼叫)")
            //因按鈕被重置，所以將所有按鈕調整回去
            
            var buttonArr = [self.yellowButton, self.greenButton, self.redButton, self.blueButton]
            var buttonSiteArr = [self.yellowButtonSite, self.greenButtonSite, self.redButtonSite, self.blueButtonSite]
            //self.greenButton.bounds.size = CGSize(width: 20, height: 20)
            for var i in 0..<buttonSiteArr.count {
                if buttonSiteArr[i] != nil {
                    buttonArr[i].bounds.size = CGSize(width: 20, height: 20)
                    buttonArr[i].center = CGPoint(x: self.image.center.x + buttonSiteArr[i]!.x * self.image.bounds.width, y: self.image.center.y + buttonSiteArr[i]!.y * self.image.bounds.height)
                    buttonArr[i].layer.borderWidth = 3
                }else {
                    buttonArr[i].layer.cornerRadius = 0
                    buttonArr[i].layer.borderWidth = 0
                }
            }
            
            
        }else {
            //尚未去過下一頁
            print("使用者還沒有去過下一頁")
            
            initButton(false)
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        //按鈕被重置在這一方法
        super.viewDidAppear(true)
        print(#function)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //setting the choosed image as imageView in this page
        image.image = receivedImage?.image
        
        print(#function)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addButton(sender: AnyObject) {
        
        let viewWidth = self.view.bounds.width
        switch numberOfButton {
        case 2 :
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                //Animation
                let buttonWidth = CGFloat(viewWidth / 3 + 1)
                print("button width is \(buttonWidth)")
                self.yellowButton.alpha = 1
                self.yellowButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                self.yellowButton.center = CGPoint(x: buttonWidth / 2, y: 480 + 0.5 * self.originalButtonHeight)
                
                //green button
                if !self.greenMoved {
                    self.greenButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                    self.greenButton.center = CGPoint(x: buttonWidth * 1.5, y: 480 + 0.5 * self.originalButtonHeight)
                }
                
                
                //red button
                if !self.redMoved {
                    self.redButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                    self.redButton.center = CGPoint(x: buttonWidth * 2.5, y: 480 + 0.5 * self.originalButtonHeight)
                }
                
                
                }, completion: { ( finished : Bool) -> Void in
                    print("Number of button become 3")
                    self.printButtonData()
            })
            
            numberOfButton++
        case 3 :
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                let buttonWidth = viewWidth / 4
                print("button width is \(buttonWidth)")
                
                
                //blue button
                self.blueButton.alpha = 1
                self.blueButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                self.blueButton.center = CGPoint(x: buttonWidth * 3.5, y: 480 + 0.5 * self.originalButtonHeight)
                
                
                //yellow button
                if !self.yellowMoved {
                    self.yellowButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                    self.yellowButton.center = CGPoint(x: buttonWidth / 2, y: 480 + 0.5 * self.originalButtonHeight)
                }
                
                
                
                
                //green button
                if !self.greenMoved {
                    self.greenButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                    self.greenButton.center = CGPoint(x: buttonWidth * 1.5, y: 480 + 0.5 * self.originalButtonHeight)
                }
                
                
                
                
                //red button
                if !self.redMoved {
                    self.redButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                    self.redButton.center = CGPoint(x: buttonWidth * 2.5, y: 480 + 0.5 * self.originalButtonHeight)
                }
                
                }, completion: { ( finished : Bool) -> Void in
                    print("Number of button become 4")
                    self.printButtonData()
            })
            
            
            numberOfButton++
        case 4 :
            print("Alertion")
            //提示使用者按鈕的最大數量
            /*
            let alertController = UIAlertController(title: nil, message: "按鈕最多只能增加到四個", preferredStyle: .Alert)
            let alert = UIAlertAction(title: nil, style: .Default, handler: nil)
            alertController.addAction(alert)
            self.presentViewController(alertController, animated: true, completion: nil)*/
            printButtonData()
        default : print("default")
        }
    }
    
    
    @IBAction func deleteButton(sender: AnyObject) {
        let viewWidth = self.view.bounds.width
        
        switch numberOfButton {
        case 2 : print("Mininum of button is 2")
        printButtonData()
        case 3 : numberOfButton--
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let buttonWidth = viewWidth / 2
            
            //yellow button
            self.yellowButton.alpha = 0
            self.yellowMoved = false
            
            //green button
            if !self.greenMoved {
                self.greenButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                self.greenButton.center = CGPoint(x: buttonWidth / 2, y: 480 + 0.5 * self.originalButtonHeight)
            }
            
            
            //red button
            if !self.redMoved {
                self.redButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                self.redButton.center = CGPoint(x: buttonWidth * 1.5, y: 480 + 0.5 * self.originalButtonHeight)
            }
            
            
            }, completion: { ( finished : Bool) -> Void in
                print("number of button become 2")
                self.printButtonData()
        })
            
        case 4 : numberOfButton--
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let viewWidth = self.view.bounds.width
            let buttonWidth = CGFloat(viewWidth / 3 + 1)
            
            //blue button
            self.blueButton.alpha = 0
            self.blueMoved = false
            
            //yellow button
            if !self.yellowMoved {
                self.yellowButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                self.yellowButton.center = CGPoint(x: buttonWidth * 0.5, y: 480 + 0.5 * self.originalButtonHeight)
            }
            
            
            //green button
            if !self.greenMoved {
                self.greenButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                self.greenButton.center = CGPoint(x: buttonWidth * 1.5, y: 480 + 0.5 * self.originalButtonHeight)
            }
            
            
            //red button
            if !self.redMoved {
                self.redButton.bounds.size = CGSize(width: buttonWidth, height: self.originalButtonHeight)
                self.redButton.center = CGPoint(x: buttonWidth * 2.5, y: 480 + 0.5 * self.originalButtonHeight)
            }
            
            }, completion: { ( finished : Bool) -> Void in
                print("number of button become 3")
                self.printButtonData()
        })
        default : print("Default")
        }
        
    }
    
    
    @IBAction func resetAllButton(sender: AnyObject) {
        //重置所有按鈕
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            let buttonSize = SettingButtonSize(viewWidth: self.view.bounds.width, numberOfButton: 2)
            
            var buttonArr = [self.yellowButton, self.greenButton, self.redButton, self.blueButton]
            
            for button in buttonArr {
                //設定所有button的大小
                button.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
                
                //消除邊框
                button.layer.borderWidth = 0
            }
            
            //設定button的中心位置
            self.greenButton.center = CGPoint(x: 0.5 * buttonSize.width, y: 480 + 0.5 * self.originalButtonHeight)
            self.redButton.center = CGPoint(x: 1.5 * buttonSize.width, y: 480 + 0.5 * self.originalButtonHeight)
            
            //設定透明度
            self.yellowButton.alpha = 0
            self.greenButton.alpha = 1
            self.redButton.alpha = 1
            self.blueButton.alpha = 0
            
            //設定按鈕是否被移動過
            self.yellowMoved = false
            self.greenMoved = false
            self.redMoved = false
            self.blueMoved = false
            
            //按鈕圓角設定
            self.yellowButton.layer.cornerRadius = 0
            self.greenButton.layer.cornerRadius = 0
            self.redButton.layer.cornerRadius = 0
            self.blueButton.layer.cornerRadius = 0
            
            
            self.numberOfButton = 2
            
            }) { (finished : Bool) -> Void in
                print("按鈕已被重置")
        }
    }
    
    
    
    /*
    @IBAction func imageViewDidPan(gesture: UIPanGestureRecognizer){
    print(gesture)
    
    if gesture.state == UIGestureRecognizerState.Began {
    print("Began")
    }else if gesture.state == .Changed{
    print("Changed")
    }
    self.image.frame.origin = gesture.locationInView(self.image)
    }*/
    
    
    //MARK: - 移動選項的手勢
    //暫存上一個location的參數
    var preLocation:CGPoint = CGPoint(x: 0, y: 0)
    //改變點的位置
    @IBAction func greenButtonGesture(gesture: UIPanGestureRecognizer) {
        print(#function)
        
        
        if gesture.state == .Began {
            print("Green button's location is being changed")
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.greenButton.bounds.size = CGSize(width: 20, height: 20)
                
                //圓角設定
                self.greenButton.layer.cornerRadius = 10
                
                //邊框設定
                self.greenButton.layer.borderWidth = 3
                self.greenButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                
                
                }, completion: { ( finished : Bool) -> Void in
                    print("Green button start to chenge")
            })
            self.preLocation = gesture.locationInView(self.greenButton)
            return
        }else if gesture.state == .Ended {
            
            print("Ending location : \(gesture.locationInView(self.greenButton))")
        }
        
        print(gesture.locationInView(self.greenButton))
        
        let currentLocation = gesture.locationInView(self.greenButton)
        
        let xOffset = currentLocation.x - self.preLocation.x
        let yOffset = currentLocation.y - self.preLocation.y
        
        self.greenButton.center.x += xOffset
        self.greenButton.center.y += yOffset
        self.greenMoved = true
        
    }
    
    @IBAction func redButtonGesture(gesture: UIPanGestureRecognizer) {
        print(__FUNCTION__)
        
        
        
        if gesture.state == .Began {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.redButton.bounds.size = CGSize(width: 20, height: 20)
                
                self.redButton.layer.cornerRadius = 10
                
                self.redButton.layer.borderWidth = 3
                self.redButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
            })
            self.preLocation = gesture.locationInView(self.redButton)
            return
        }else if gesture.state == .Ended {
            print("Ending location :  \(gesture.locationInView(self.redButton))")
        }
        
        print(gesture.locationInView(self.redButton))
        
        let currentLocation = gesture.locationInView(self.redButton)
        
        let xOffset = currentLocation.x - self.preLocation.x
        let yOffset = currentLocation.y - self.preLocation.y
        
        self.redButton.center.x += xOffset
        self.redButton.center.y += yOffset
        self.redMoved = true
        
    }
    
    
    @IBAction func yelloButtonGesture(gesture: UIPanGestureRecognizer) {
        print(__FUNCTION__)
        
        
        if gesture.state == .Began {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.yellowButton.bounds.size = CGSize(width: 20, height: 20)
                self.yellowButton.layer.cornerRadius = 10
                
                self.yellowButton.layer.borderWidth = 3
                self.yellowButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
                
            })
            self.preLocation = gesture.locationInView(self.yellowButton)
            return
        }else if gesture.state == .Ended {
            print("Ending location :  \(gesture.locationInView(self.yellowButton))")
        }
        
        print(gesture.locationInView(self.yellowButton))
        
        let currentLocation = gesture.locationInView(self.yellowButton)
        
        let xOffset = currentLocation.x - self.preLocation.x
        let yOffset = currentLocation.y - self.preLocation.y
        
        self.yellowButton.center.x += xOffset
        self.yellowButton.center.y += yOffset
        self.yellowMoved = true
    }
    
    
    @IBAction func blueButtonGesture(gesture: UIPanGestureRecognizer) {
        print(__FUNCTION__)
        
        
        if gesture.state == .Began {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.blueButton.bounds.size = CGSize(width: 20, height: 20)
                
                self.blueButton.layer.cornerRadius = 10
                
                self.blueButton.layer.borderWidth = 3
                self.blueButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
            })
            self.preLocation = gesture.locationInView(self.blueButton)
            return
        }else if gesture.state == .Ended {
            print("Ending location :  \(gesture.locationInView(self.blueButton))")
        }
        
        print(gesture.locationInView(self.blueButton))
        
        let currentLocation = gesture.locationInView(self.blueButton)
        
        let xOffset = currentLocation.x - self.preLocation.x
        let yOffset = currentLocation.y - self.preLocation.y
        
        self.blueButton.center.x += xOffset
        self.blueButton.center.y += yOffset
        self.blueMoved = true
    }
    
    func printButtonData() {
        print("Green Button location \(self.greenButton.center)")
        print("Green Button size \(self.greenButton.bounds)")
        
        print("Red Button location \(self.redButton.center)")
        print("Red Button size \(self.redButton.bounds)")
        
        print("Yellow Button location \(self.yellowButton.center)")
        print("Yellow Button size \(self.yellowButton.center)")
        
        print("Blue Button location \(self.blueButton.center)")
        print("Blue Button size \(self.blueButton.center)")
    }
    
    
    func initButton(withAnimate : Bool) {
        //將按鈕重置
        
        
        if !self.toNextPage {
            //只顯示2個button，首次進入該頁面
            
            var buttonSize = SettingButtonSize(viewWidth: self.view.bounds.width, numberOfButton: 2)
            
            var buttonArr = [self.yellowButton, self.greenButton, self.redButton, self.blueButton]
            
            for button in buttonArr {
                //設定所有button的大小
                button.bounds.size = CGSize(width: buttonSize.width, height: buttonSize.height)
            }
            
            //設定button的中心位置
            self.greenButton.center = CGPoint(x: 0.5 * buttonSize.width, y: 480 + 0.5 * self.originalButtonHeight)
            self.redButton.center = CGPoint(x: 1.5 * buttonSize.width, y: 480 + 0.5 * self.originalButtonHeight)
            
            //設定透明度
            self.yellowButton.alpha = 0
            self.greenButton.alpha = 1
            self.redButton.alpha = 1
            self.blueButton.alpha = 0
            
            //設定按鈕是否被移動過
            self.yellowMoved = false
            self.greenMoved = false
            self.redMoved = false
            self.blueMoved = false
            
            //重置button數量參數
            self.numberOfButton = 2
        }
        
        
    }
    
    var yellowButtonSite : PointRelativePosition? = nil
    var greenButtonSite : PointRelativePosition? = nil
    var redButtonSite : PointRelativePosition? = nil
    var blueButtonSite : PointRelativePosition? = nil
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("正在去下一頁的路上 : \(__FUNCTION__)")
        
        self.toNextPage = true
        //記錄相對座標
        
        
        if segue.identifier == "addToPost" {
            var nextViewController = segue.destinationViewController as? PostInfoViewController
            
            
            //傳送影像資訊
            nextViewController?.receivedImage = self.image.image
            nextViewController?.numberOfButton = self.numberOfButton
            
            //判斷是否被移動至影像範圍內，更改為依照圖形比例計算
            if(self.greenMoved && pointIsInTheImage(self.greenButton, imageView: self.image)){
                greenButtonSite = PointRelativePosition(button: self.greenButton, imageView: self.image)
                nextViewController?.greenButtonSite = PointRelativePosition(button: self.greenButton, imageView: self.image)
            }
            
            if self.redMoved && pointIsInTheImage(self.redButton, imageView: self.image) {
                redButtonSite = PointRelativePosition(button: self.redButton, imageView: self.image)
                nextViewController?.redButtonSite = PointRelativePosition(button: self.redButton, imageView: self.image)
            }
            
            if self.yellowMoved && pointIsInTheImage(self.yellowButton, imageView: self.image){
                yellowButtonSite = PointRelativePosition(button: self.yellowButton, imageView: self.image)
                nextViewController?.yellowButtonSite = PointRelativePosition(button: self.yellowButton, imageView: self.image)
            }
            
            if self.blueMoved && pointIsInTheImage(self.blueButton, imageView: self.image) {
                blueButtonSite = PointRelativePosition(button: self.blueButton, imageView: self.image)
                nextViewController?.blueButtonSite = PointRelativePosition(button: self.blueButton, imageView: self.image)
            }
            
        }
        
    }
    
    
    
    func pointIsInTheImage(button : UIButton, imageView : UIImageView) -> Bool {
        //輔助segue檢查點是否被移動到圖片的區域
        if (button.center.x >= imageView.center.x - imageView.bounds.width / 2 &&
            button.center.x <= imageView.center.x + imageView.bounds.width / 2 &&
            button.center.y <= imageView.center.y + imageView.bounds.height / 2 &&
            button.center.y >= imageView.center.y - imageView.bounds.height / 2) {
                return true
        }
        return false
    }
}



struct PointRelativePosition {
    //在離開頁面時計算點與圖片之間的相對位置(比例)
    var x : CGFloat
    var y : CGFloat
    
    init( button : UIButton, imageView : UIImageView){
        self.x = (button.center.x - imageView.center.x) / imageView.bounds.width
        self.y = (button.center.y - imageView.center.y) / imageView.bounds.height
    }
    
    init() {
        self.x = 0
        self.y = 0
    }
    
}

struct ButtonPosition {
    //提供按鈕的中心位置的資訊
    var x : CGFloat
    var y : CGFloat
    
    //協助按鈕對其用
    var times : CGFloat
    
    init(viewWidth  :CGFloat, numberOfButton : CGFloat){
        var buttonSize = SettingButtonSize(viewWidth: viewWidth, numberOfButton: numberOfButton)
        self.x = 0.5 * buttonSize.width
        self.y = 480 + 44 / 2
        self.times = 0.5
    }
    
    mutating func toNextButtonXSite() {
        //轉移到下一按鈕的x中點位置
        self.times = self.times + 1
    }
}

struct SettingButtonSize {
    //提供按鈕的大小的資訊
    var width : CGFloat
    var height : CGFloat
    
    init(viewWidth : CGFloat, numberOfButton : CGFloat) {
        self.width = viewWidth / numberOfButton
        self.height = 44
    }
}