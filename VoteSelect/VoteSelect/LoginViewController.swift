//
//  LoginViewController.swift
//  VoteSelect
//
//  Created by BEN on 23/12/2015.
//  Copyright © 2015年 8en7am1n. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
//    override func viewDidLayoutSubviews(){
//
//        let viewWidth = self.view.bounds.width
//        let viewHeight = self.view.bounds.height
//        let buttonWidth = viewWidth / 2
//
//        self.signUpButton.bounds.size = CGSize(width: buttonWidth - 33, height: 30)
//        self.signUpButton.center = CGPoint(x: viewWidth - 0.57 * buttonWidth, y: 210)
//    
//        self.forgetPasswordButton.bounds.size = CGSize(width: buttonWidth - 33, height: 30)
//        self.forgetPasswordButton.center = CGPoint(x: 0.57 * buttonWidth, y: 210)
//        
//    }
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
        //為了能夠關閉註冊畫面，我們需要定義用來解除的 Segue
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        let userName = self.textUserName.text
        let password = self.textPassword.text
        
        // 驗證文字欄位
        if let userName = userName where userName.characters.count < 5 {
            let alert = UIAlertView(title: "Invalid", message: "請輸入有效的用戶名稱", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
//        } else if let password = password where password.characters.count < 8 {
//            let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
            
        } else {
            // 顯示旋轉圖示，代表工作正在進行中
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // 送出登入的要求
            PFUser.logInWithUsernameInBackground(userName!, password: password!, block: { (user, error) -> Void in
                
                // 停止旋轉圖示
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBar")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    let alert = UIAlertView(title: "Error", message: "用戶名稱或密碼不正確", delegate: self, cancelButtonTitle: "OK")
//                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.addTextUserName()
        
        loginButton.layer.cornerRadius = 20 //圓半徑

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        //Calls this function when the tap is recognized.
        
        initializeTextFields()//呼叫鍵盤設置
    }
    
    func initializeTextFields(){
        //鍵盤限制
        textUserName.delegate = self
        textUserName.keyboardType = UIKeyboardType.ASCIICapable
        textPassword.delegate = self
        textPassword.keyboardType = UIKeyboardType.ASCIICapable
        //清除按鈕
        textUserName.clearButtonMode=UITextFieldViewMode.WhileEditing
        textPassword.clearButtonMode=UITextFieldViewMode.WhileEditing
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func dismissKeyboard() { //鍵盤消失
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func addTextUserName(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: textUserName.frame.size.height - width , width:  textUserName.frame.size.width, height: textUserName.frame.size.height)
        
        border.borderWidth = width
        textUserName.layer.addSublayer(border)
        textUserName.layer.masksToBounds = true
        //加底線
    }
    
}
